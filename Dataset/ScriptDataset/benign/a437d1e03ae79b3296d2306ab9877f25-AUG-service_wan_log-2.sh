        if [ ! -f $WAN_LOG_FILE ];then
                touch $WAN_LOG_FILE
        fi
	echo "`date` `sysevent get pppd_current_wan_ipaddr` $1" >> $WAN_LOG_FILE
        LINES=`cat $WAN_LOG_FILE | wc -l`
        if [ $LINES -gt 50 ];then
		mv $WAN_LOG_FILE /tmp/_tmp_wan_log
		tail -n 50 /tmp/_tmp_wan_log > $WAN_LOG_FILE
	fi
