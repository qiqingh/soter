	vlan_enable=`nvram_get 2860 vlan_enable`
	if [ "$vlan_enable" != "1" ]; then
		return;
    	fi

	# correct default vlan prio mapping to fix SAVANNAH-82 issue
	switch reg w 50 2da824a0
        dup_vlan_id=0
        vlan_mapping_port1=1
        vlan_mapping_port2=1

        # check if port3 and port4 have the same vlan id
	lan3_vcount=`nvram_get 2860 vlan_count_3`
	lan4_vcount=`nvram_get 2860 vlan_count_4`
	if [ $lan3_vcount -gt 0 -a $lan4_vcount -gt 0 ]; then
            lan3_vid=`nvram_get 2860 vlan_id_3`
	    lan4_vid=`nvram_get 2860 vlan_id_4`
	    lan3_port_tagging=`nvram_get 2860 vlan_tag_3`
	    lan4_port_tagging=`nvram_get 2860 vlan_tag_4`

	    if [ $lan3_vid = $lan4_vid -a "$lan3_port_tagging" != "" -a "$lan4_port_tagging" != "" ]; then
		dup_vlan_id=1
	    fi
	fi

	for lan_no in 3 4 ; do
		count=`nvram_get 2860 vlan_count_$lan_no`
		if [ "$count" = "0" ]; then
	   		#Disable 802.1Q Mode
	    		echo "Disable 802.1Q Mode"
		fi
		c=1
		vid=`nvram_get 2860 vlan_id_$lan_no`
		prio=`nvram_get 2860 vlan_pri_$lan_no`
		port_no=$(expr 5 - $lan_no)
		index=$vid

		port_tagging=`nvram_get 2860 vlan_tag_$lan_no`

		while [ $c -le $count ]; do
			set_vlan_settings $port_no $vid $prio $port_tagging
			if [ "$port_tagging" = "Untagged" -o "$port_tagging" = "Tagged" ]; then
				if [ "$lan_no" = "3" ]; then
					vlan_mapping_port2=0
				fi
				if [ "$lan_no" = "4" ]; then
					vlan_mapping_port1=0
				fi
	    		fi
			c=`expr $c + 1`
		done
		if [ "$dup_vlan_id" = "0" -a $count -gt 0 ]; then
			#result save as port_list
			calculate_port_list $port_no		
			#set port and port6 as the same vid group.
			echo "switch vlan set ${index} ${vid} ${port_list}" >> ${vlan_setup_f}		
		elif [ "$lan_no" == "3" ]; then
			echo "#set vlan with vid3 = vid4"  >> ${vlan_setup_f} 
			echo "switch vlan set ${index} ${vid} 11100000" >> ${vlan_setup_f}		
		fi
	done

	#After excluding vlan, set up the default group.
        echo "switch vlan set 0 1 0${vlan_mapping_port1}${vlan_mapping_port2}11010" >> ${vlan_setup_f}
