    LOCAL_CONF_FILE=/tmp/pmon.conf$$
    rm -f $LOCAL_CONF_FILE
    do_check_syseventd
    COUNT=`sysevent get pmon_feature_count`
    if [ "" = "$COUNT" ] ; then
        COUNT=0
    fi
    for ct in `seq 1 $COUNT`
    do
        feature=`sysevent get pmon_feature_$ct`
        if [ "" != "$feature" ] ; then
            PROC_ENTRY=`sysevent get pmon_proc_$feature`
            if [ "" != "$PROC_ENTRY" ] ; then
                process_name=`echo $PROC_ENTRY | cut -d' ' -f1`
                pid=`echo $PROC_ENTRY | cut -d' ' -f2`
                restartcmd=`echo $PROC_ENTRY | cut -d' ' -f3-`
                if [ "" != "$process_name" ] && [ "" != "$pid" ] && [ "" != "$restartcmd" ] ; then
                    echo "$process_name $pid $restartcmd" >> $LOCAL_CONF_FILE
                fi
            fi
        fi
   done
   
   cat $LOCAL_CONF_FILE > $CONF_FILE
   rm -f $LOCAL_CONF_FILE
   $BIN $CONF_FILE
