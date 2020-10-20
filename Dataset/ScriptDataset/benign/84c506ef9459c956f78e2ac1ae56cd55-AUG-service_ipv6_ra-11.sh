   calculate_services_to_start
   if [ "1" = "$FW_RESTART_REQ" ] ; then
      sysevent set firewall-restart
   fi
   if [ "1" = "$RADVD_REQ" ] ; then
      do_start_radvd
   fi
