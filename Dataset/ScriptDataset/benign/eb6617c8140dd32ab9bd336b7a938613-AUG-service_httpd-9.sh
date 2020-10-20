   define_lighttpd_env
   killall $BIN
   rm -f $PID_FILE $PASSWORD_FILE
   ulog httpd status "Restoring non-lan access to ports $($BLOCK list)"
   $BLOCK stop
