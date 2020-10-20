   if [ "0" != "$SYSCFG_ddns_enable" ] ; then
      clear_connect_generic_error_only           
      update_ddns_if_needed
   else
      ulog ddns status "$PID ddns is disabled clear last return and wan ipaddr"
      sysevent set ddns_return_status # to make sure we are not blocked by the previous error when enabled back
      sysevent set wan_last_ipaddr # to make sure we do check DDNS remote IP address when enabled back
   fi
