   calculate_services_to_start
   if [ "1" = "$FW_RESTART_REQ" ] ; then
      sysevent set firewall-restart
   fi
   if [ "1" = "$ROUTED_REQ" ] ; then
      do_start_zebra
      sysevent set ${SERVICE_NAME}-errinfo
      sysevent set ${SERVICE_NAME}-status started
   fi
   if [ "1" = "$RIPD_REQ" ] ; then
      do_start_ripd
      sysevent set rip-errinfo
      sysevent set rip-status started
   fi
