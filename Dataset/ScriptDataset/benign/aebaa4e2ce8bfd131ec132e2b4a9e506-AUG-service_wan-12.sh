   install_wan_status_monitor
   ulog wan status "$PID Bringing up wan interface $SYSCFG_ifname"
   sysevent set interface-start $SYSCFG_ifname
   MAX_TRIES=20
   TRIES=1
   while [ "$MAX_TRIES" -gt "$TRIES" ] ; do
      STATUS=`sysevent get ${SYSCFG_ifname}-status`
      if [ "started" = "$STATUS" ] ; then
         TRIES=$MAX_TRIES
      else
         sleep .5
         TRIES=`expr $TRIES + 1`
      fi
   done
   ulog wan status "$PID interface $SYSCFG_ifname status: $STATUS"
   sysevent set ${1}-status starting
   S=`sysevent get ${1}_current_ipv4_wan_state`
   if [ -z "$S" ] ; then
      sysevent set ${1}_current_ipv4_wan_state down
   fi
   S=`sysevent get ${1}_current_ipv4_link_state`
   if [ -z "$S" ] ; then
      sysevent set ${1}_current_ipv4_link_state down
   fi
   if [ -z "$SYSCFG_wan_virtual_ifnum" -o "-1" = "$SYSCFG_wan_virtual_ifnum" ] ; then
      SYSCFG_wan_virtual_ifnum=
      SYSEVENT_current_wan_ifname=$SYSCFG_ifname
   else
      if [ -n "$SYSCFG_hardware_vendor_name" -a "Broadcom" = "$SYSCFG_hardware_vendor_name" ] ; then
         SYSEVENT_current_wan_ifname="vlan${SYSCFG_wan_virtual_ifnum}"
      else
         SYSEVENT_current_wan_ifname="${SYSCFG_wan_ifname}.${SYSCFG_wan_virtual_ifnum}"
      fi
   fi
   if [ "1" = "$SYSCFG_default" ] ; then
      sysevent set current_wan_ifname $SYSEVENT_current_wan_ifname
   fi
   sysevent set ${1}_current_wan_ifname $SYSEVENT_current_wan_ifname
   sysevent set ${1}_phylink_wan_state `sysevent get phylink_wan_state`
   register_handlers $1
   if [ "1" = "$SYSCFG_default" ] ; then
      sysevent set ipv4_wan_ipaddr 0.0.0.0
   fi
   sysevent set ${1}_ipv4_wan_ipaddr 0.0.0.0
   set_wan_mtu
   if [ "$?" -ne "0" ] ; then
      return 3 
   fi
   clone_mac_addr
   sysevent set ${SYSEVENT_current_wan_ifname}_syscfg_namespace  $NAMESPACE
   ulog wan status "$PID setting ${1}_desired_ipv4_link_state up for $1"
   sysevent set ${1}_desired_ipv4_link_state up
   ulog wan status "$PID setting ${1}_desired_ipv4_wan_state up for $1"
   sysevent set ${1}_desired_ipv4_wan_state up
