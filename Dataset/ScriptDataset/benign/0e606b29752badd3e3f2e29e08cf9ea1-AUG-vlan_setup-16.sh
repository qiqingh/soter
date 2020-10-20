
    vlan_enable=`syscfg get vlan_tagging::enabled`
    if [ "$vlan_enable" = "1" ]; then
	# correct default vlan prio mapping to fix SAVANNAH-82 issue
	switch reg w 50 2da824a0
        dup_vlan_id=0
        vlan_mapping_port3=1
        vlan_mapping_port4=1
        #switch vlan set 0 1 00001111
	#mao: set wan port ?? why??
        #switch vlan set 0 1 11000111
        switch vlan set 2 2 00001010
        # check if port3 and port4 have the same vlan id
	lan3_vcount=`syscfg get lan_2::vlan_count`
	lan4_vcount=`syscfg get lan_3::vlan_count`
	if [ $lan3_vcount -gt 0 -a $lan4_vcount -gt 0 ]; then
            lan3_vid=`syscfg get lan_2::vlan_id_1`
	    lan4_vid=`syscfg get lan_3::vlan_id_1`
	    lan3_port_num=`syscfg get lan_2::port_numbers_1`
	    lan4_port_num=`syscfg get lan_3::port_numbers_1`
	    lan3_port_tagging=$(echo $lan3_port_num | cut -f 2 -d ' ')
	    lan4_port_tagging=$(echo $lan4_port_num | cut -f 3 -d ' ')

	    if [ $lan3_vid = $lan4_vid -a "$lan3_port_tagging" -ne "3" -a "$lan4_port_tagging" -ne "3" ]; then
		dup_vlan_id=1
		lan3_prio=`syscfg get lan_2::prio_1`
		lan4_prio=`syscfg get lan_3::prio_1`
		index="${lan3_vid}" #set the index the same vid

		dec_to_hex $lan3_vid
	    	# Set ACL pattern
		switch reg w 44 111117
		switch reg w 94 ff0${VID_HEX}
		switch reg w 98 8ff0e
		switch reg w 90 80005000
	    	# ACL Rule 0 Use Pattern 0
		switch reg w 94 1
		switch reg w 98 0
		switch reg w 90 80009000
	    	# ACL Rule 0 enter UP prio queue 
		switch reg w 94 ${lan3_prio}0
		switch reg w 98 0
		switch reg w 90 8000b000

		vlan_mapping_port3=0
		vlan_mapping_port4=0

		create_vlan_bridge $lan3_vid $lan3_prio

           	# 1. port3 and port4 are both untagged
		if [ "$lan3_port_tagging" = "1" -a "$lan4_port_tagging" = "1" ]; then
		    lan3_prio=`expr $lan3_prio \* 2`  # ==> lan3_prio=lan3_prio * 2
		    LAN3_PRIO_HEX=${HEX_ARRAY:$lan3_prio:1}
		    #port4 untagged
		    switch vlan port-attr 3 0	#set user port.(user port:0; transparent port:3)
		    switch vlan acc-frm 3 2	#set switch vlan acceptable_frame type (admit only untagged or priority-tagged frames: 2)
		    switch vlan eg-tag-pcr 3 0	#traffic from port is untagged.(untagged: 0, tagged: 2)
		    switch vlan eg-tag-pvc 3 6 	#Traffic leaving switch(p6) is tagged.( (untagged:4, tagged:6))
		    switch reg w 2314 1${LAN3_PRIO_HEX}${VID_HEX} #set group vlan id of port 4
		    #port3 untagged
		    switch vlan port-attr 2 0
		    switch vlan acc-frm 2 2	#set switch vlan acceptable_frame type (admit only untagged or priority-tagged frames: 2)
		    switch vlan eg-tag-pcr 2 0
		    switch vlan eg-tag-pvc 2 6
		    switch reg w 2214 1${LAN3_PRIO_HEX}${VID_HEX} #set group vlan id of port 3

		    echo "set group vid, 3-unttag|4-untag, CMD[switch reg w 2214 1${LAN3_PRIO_HEX}${VID_HEX} ]">/dev/console

		    switch reg w 94 101c0001  # port number 5, 3 and 4 (1c = 0001 1100)
		    #switch reg w 98 300       # egress tag enable for port 5 (300 = 11 0000 0000)
		    switch reg w 90 80001${VID_HEX} # set vlan id
		fi
            	# 2. port3 and port4 are both tagged
		if [ "$lan3_port_tagging" = "2" -a "$lan4_port_tagging" = "2" ]; then
		    #port4 tagged
		    switch vlan port-attr 3 0	#set user port.(user port:0; transparent port:3)
		    switch vlan acc-frm 3 1	#set switch vlan acceptable_frame type (admit only vlan-taged frames: 1)
		    switch vlan eg-tag-pcr 3 2	#traffic from port is untagged.(untagged: 0, tagged: 2)
		    switch vlan eg-tag-pvc 3 6 	#Traffic leaving switch(p6) is tagged.( (untagged:4, tagged:6))
		    switch reg w 2314 1${LAN3_PRIO_HEX}${VID_HEX} #set group vlan id of port 4
		    #port3 tagged
		    switch vlan port-attr 2 0
		    switch vlan acc-frm 2 1	#set switch vlan acceptable_frame type (admit only vlan-taged frames: 1)
		    switch vlan eg-tag-pcr 2 2	#traffic from port is untagged.(untagged: 0, tagged: 2)
		    switch vlan eg-tag-pvc 2 6
		    switch reg w 2214 1${LAN3_PRIO_HEX}${VID_HEX} #set group vlan id of port 3

		    echo "set group vid, 3-tag|4-tag, CMD[switch reg w 2214 1${LAN3_PRIO_HEX}${VID_HEX} ]">/dev/console

		    switch reg w 94 101c0001 # port member 5, 3 and 4 (1c = 0001 1100)
		    switch reg w 98 3f0 # egress tag enable for port 5, 3 and 4(3F0 = 0011 1111 0000)
		    switch reg w 90 80001${VID_HEX} # set vlan id
		fi
          	# 3. port3 is tagged and port4 is untagged     
		if [ "$lan3_port_tagging" = "2" -a "$lan4_port_tagging" = "1" ]; then
		    lan4_prio=`expr $lan4_prio \* 2`
		    LAN4_PRIO_HEX=${HEX_ARRAY:$lan4_prio:1} 
		    #port4 untagged
		    switch vlan port-attr 3 0	#set user port.(user port:0; transparent port:3)
		    switch vlan acc-frm 3 2	#set switch vlan acceptable_frame type (admit only untagged or priority-tagged frames: 2)
		    switch vlan eg-tag-pcr 3 0	#traffic from port is untagged.(untagged: 0, tagged: 2)
		    switch vlan eg-tag-pvc 3 6 	#Traffic leaving switch(p6) is tagged.( (untagged:4, tagged:6))
		    switch reg w 2314 1${LAN3_PRIO_HEX}${VID_HEX} #set group vlan id of port 4
		    #port3 tagged
		    switch vlan port-attr 2 0
		    switch vlan acc-frm 2 1	#set switch vlan acceptable_frame type (admit only vlan-taged frames: 1)
		    switch vlan eg-tag-pcr 2 2	#traffic from port is untagged.(untagged: 0, tagged: 2)
		    switch vlan eg-tag-pvc 2 6
		    switch reg w 2214 1${LAN3_PRIO_HEX}${VID_HEX} #set group vlan id of port 3

		    echo "set group vid, 3-tag|4-untag, CMD[switch reg w 2214 1${LAN3_PRIO_HEX}${VID_HEX} ]">/dev/console

		    #will affect p0~p4, why ??
		    switch reg w 94 101c0001 # port number 5, 3 and 4 (1c = 0001 1100)
		    switch reg w 98 330 # egress tag enable for port 5 and 3(330 = 11 0011 0000)
		    switch reg w 90 80001${VID_HEX} # set vlan id
		fi
            	# 4. port3 is untagged and port4 is tagged
		if [ "$lan3_port_tagging" = "1" -a "$lan4_port_tagging" = "2" ]; then
		    lan3_prio=`expr $lan3_prio \* 2`
		    LAN3_PRIO_HEX=${HEX_ARRAY:$lan3_prio:1}
		    #port4 tagged
		    switch vlan port-attr 3 0	#set user port.(user port:0; transparent port:3)
		    switch vlan acc-frm 3 1	#set switch vlan acceptable_frame type (admit only vlan-taged frames: 1)
		    switch vlan eg-tag-pcr 3 2	#traffic from port is untagged.(untagged: 0, tagged: 2)
		    switch vlan eg-tag-pvc 3 6 	#Traffic leaving switch(p6) is tagged.( (untagged:4, tagged:6))
		    switch reg w 2314 1${LAN3_PRIO_HEX}${VID_HEX} #set group vlan id of port 4
		    #port3 untagged
		    switch vlan port-attr 2 0
		    switch vlan acc-frm 2 2	#set switch vlan acceptable_frame type (admit only untagged or priority-tagged frames: 2)
		    switch vlan eg-tag-pcr 2 0	#traffic from port is untagged.(untagged: 0, tagged: 2)
		    switch vlan eg-tag-pvc 2 6
		    switch reg w 2214 1${LAN3_PRIO_HEX}${VID_HEX} #set group vlan id of port 3

		    echo "set group vid, 3-untag|4-tag, CMD[switch reg w 2214 1${LAN3_PRIO_HEX}${VID_HEX} ]">/dev/console

		    switch reg w 94 101c0001	#port number 5, 3 and 4 (1c = 0001 1100)
		    switch reg w 98 3c0		#egress tag enable for port 5, 4(3c0 = 11 1100 0000)
		    switch reg w 90 80001${VID_HEX}
		fi 

		#set vid idx 0.
		switch vlan set ${index} ${lan3_vid} 00111010
		#set switch port6(cpu port) as user port.
		switch reg w 2610 81000000
		#switch vlan port-attr 6 0

	    fi #end of [ lan3_vid == lan4_vid && tag3 != 3 && atg4 !=3 ]
	fi #end of [ $lan3_vcount > 0 && $lan4_vcount > 0 ]

        if [ "$dup_vlan_id" = "0" ]; then
    	    for lan_no in 2 3 ; do
    	        count=`syscfg get lan_$lan_no::vlan_count`
    	        if [ "$count" = "0" ]; then
    	            #Disable 802.1Q Mode
    	            echo "Disable 802.1Q Mode"
    	        fi
    	        c=1
    	        while [ $c -le $count ]; do
    	            vid=`syscfg get lan_$lan_no::vlan_id_$c`
    	            prio=`syscfg get lan_$lan_no::prio_$c`
    	            port_numbers=`syscfg get lan_$lan_no::port_numbers_$c`

		    create_vlan_bridge $vid $prio

    	            for port_no in 2 3; do
    	                port_tagging=$(echo $port_numbers | cut -f $port_no -d ' ')
		    	# port_tagging value as below:
    	            	# 1 - untagged
    	            	# 2 - tagged
    	            	# 3 - not a member
    	                if [ "$port_tagging" = "1" ]; then
    	                    #set_untagged_vlan `expr $port_no + 1` $vid $prio
    	    		    set_untagged_vlan_MT7531 $port_no $vid $prio
    	                    if [ "$port_no" = "2" ]; then
    	                        vlan_mapping_port3=0
    	                    fi
    	                    if [ "$port_no" = "3" ]; then
    	                        vlan_mapping_port4=0
    	                    fi
    	                elif [ "$port_tagging" = "2" ]; then
    	                    #set_tagged_vlan `expr $port_no + 1` $vid $prio
    	    		    set_tagged_vlan_MT7531 $port_no $vid $prio
    	                    if [ "$port_no" = "2" ]; then
    	                        vlan_mapping_port3=0
    	                    fi
    	                    if [ "$port_no" = "3" ]; then
    	                        vlan_mapping_port4=0
    	                    fi
    	                fi
    	            done
    	            c=`expr $c + 1`
    	        done
    	    done
    	fi

	#After excluding vlan, set up the default group.
	echo "set vlan idx 0 as CMD[switch vlan set 0 1 11${vlan_mapping_port3}${vlan_mapping_port4}0010 ]">/dev/console
        switch vlan set 0 1 11${vlan_mapping_port3}${vlan_mapping_port4}0010

        # set default vid for wan port
        vid=`syscfg get wan_1::vlan_id`
        prio=`syscfg get wan_1::prio`
	#don't set switch command in this function, it will affect p0~p3 to not working.
        set_wan_vlan $vid $prio
    fi
