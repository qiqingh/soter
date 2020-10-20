
    NOWTIME=$(date +'%H')
    PPPTIME=$(mf_load_setting milkfish_ppptime)
    SYNCHRONE=FALSE
    if [ $PPPTIME ] && [ $PPPTIME != "off" ]; then
	#echo "Last: $TIMESTAMP"
	#echo "Now: $NOWTIME"
	#echo "Preset: $PPPTIME"
	if [ $NOWTIME -eq $PPPTIME ] ; then
	
    	    if [ -r $TIMESTAMPFILE ] ; then
		TIMESTAMP=$(tail -1 $TIMESTAMPFILE  | awk -F: '{print $1}')
        	if [ $TIMESTAMP -eq $PPPTIME ] ; then
        	    #echo "Last reconnect was in the same hour of day..."
            	    date +'%H:%M:%S %y-%m-%d - reconnect cancelled' >> $TIMESTAMPFILE
		    SYNCHRONE=TRUE
		else
		    date +'%H:%M:%S %y-%m-%d - commencing reconnect' >> $TIMESTAMPFILE
		fi
    	    fi
	    
	    if [ $SYNCHRONE = "FALSE" ] ; then
        	#echo "It is the right hour for a reconnect..."
		mf_feedback "INFO: Commencing PPPoE reconnect..."
        	milkfish_services audit router && \
        	if [ -r $OPENSERPIDFILE ] ; then
	    	    milkfish_services audit openser && \
    	    	    openserctl stop
        	fi			
        	ifdown wan && \
		sleep 5 && \
    	        ifup wan && \
		sleep 30
	    fi
        else
	    mf_feedback "INFO: Not the right hour for a PPPoE reconnect."
	fi
    else
        mf_feedback "ERROR: Automatic PPPoE reconnect disabled or no preset reconnection time found."
    fi
