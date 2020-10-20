   define_lighttpd_env
   killall $BIN
   rm -f $PID_FILE $PASSWORD_FILE
    asyncid=`sysevent get httpd_firewall_asyncid`
    if [ -n "$asyncid" ] ; then
        sysevent rm_async $asyncid
        sysevent set httpd_firewall_asyncid
    fi
   ulog httpd status "Restoring non-lan access to ports $($BLOCK list)"
   $BLOCK stop
