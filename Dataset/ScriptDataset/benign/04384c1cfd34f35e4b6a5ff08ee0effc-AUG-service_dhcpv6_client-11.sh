   if [ "$SYSCFG_dhcpv6c_enable" = "0" ] 
   then
      ulog dhcpv6c status "DHCPv6 client is disabled. Ignoring service start request"
      return
   fi
   if [ "$SYSCFG_dhcpv6c_enable" = "1" -o "$SYSCFG_dhcpv6c_enable" = "3" ] ; then
      NEED_PD=1
   else
      NEED_PD=0
   fi
   if [ "$SYSCFG_dhcpv6c_enable" = "2" -o "$SYSCFG_dhcpv6c_enable" = "3" ] ; then
      NEED_NA=1
   else
      NEED_NA=0
   fi
   if [ -n "$DHCPV6_CLIENT_ACCEPT_INCOMPLETE_LEASE" ] ; then
      if [ "$SYSCFG_dhcpv6c_enable" = "3" ] ; then
         SYSEVENT_dhcpv6_client_current_config=`sysevent get dhcpv6_client_current_config`
         if [ -z "$SYSEVENT_dhcpv6_client_current_config" ] ; then
            sysevent set dhcpv6_client_current_config 3
         elif [ "$SYSEVENT_dhcpv6_client_current_config" = "3" ] ; then
            sysevent set dhcpv6_client_current_config 1
            NEED_PD=1
            NEED_NA=0
            ulog dhcpv6c status "DHCPv6 client cannot get NA and PD. Trying PD only"
         elif [ "$SYSEVENT_dhcpv6_client_current_config" = "1" ] ; then
            sysevent set dhcpv6_client_current_config 2
            NEED_PD=0
            NEED_NA=1
            ulog dhcpv6c status "DHCPv6 client cannot get NA and PD. Trying NA only"
         else
            sysevent set dhcpv6_client_current_config 4
            NEED_PD=1
            NEED_NA=1
         fi
      fi
   fi
   if [ "$NEED_PD" = "1" ] ; then
      PD_FLAG=" -P "
   else
      PD_FLAG=""
   fi
   if [ "$NEED_NA" = "1" ] ; then
      NA_FLAG=" -N "
   else
      NA_FLAG=""
   fi
   if [ "$NEED_NA" = "0" -a "$NEED_PD" = "0" ] ; then
      ulog dhcpv6c status "DHCPv6 client is not needed for IA_NA nor IA_PD. Ignoring startup request of DHCPv6 client"
   fi
   wait_till_end_state ${SERVICE_NAME}
   STATUS=`sysevent get ${SERVICE_NAME}-status`
   if [ "started" != "$STATUS" ] 
   then
      sysevent set ${SERVICE_NAME}-errinfo 
      sysevent set ${SERVICE_NAME}-status starting
      restore_dhcpv6c_duid
      sysevent set ${SYSCFG_lan_ifname}_ipv6_deprecated_but_valid_delegated_address
      sysevent set ${SYSCFG_guest_lan_ifname}_ipv6_deprecated_but_valid_delegated_address
     
      prepare_dhcpv6_client_config_file $WAN_INTERFACE_NAME
      prepare_leases_file
      prepare_dhcpv6_callback_file
      ulog dhcpv6c status "Calling $DHCPV6_BINARY -6 $PD_FLAG $NA_FLAG -pf $DHCPV6_PID_FILE -cf $DHCPV6_CONF_FILE -lf $LEASES_FILE -sf $SCRIPT_FILE $WAN_INTERFACE_NAME &"
      $DHCPV6_BINARY -6 $PD_FLAG $NA_FLAG -pf $DHCPV6_PID_FILE -cf $DHCPV6_CONF_FILE -lf $LEASES_FILE -sf $SCRIPT_FILE $WAN_INTERFACE_NAME & >> $LOG 2>&1
      if [ -n "$DHCPV6_CLIENT_ACCEPT_INCOMPLETE_LEASE" ] ; then
         prepare_dhcpv6_check_progress_script
      fi
      check_err_exit $? "$DHCPV6_BINARY result"
      sysevent set ${SERVICE_NAME}-status started
   fi
