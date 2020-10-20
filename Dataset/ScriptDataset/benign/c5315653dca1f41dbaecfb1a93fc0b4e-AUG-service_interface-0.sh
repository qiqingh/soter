#!/bin/sh 
source /etc/init.d/ulog_functions.sh
source /etc/init.d/event_handler_functions.sh
source /etc/init.d/interface_functions.sh
if [ -f /etc/init.d/brcm_ethernet_helper.sh ]; then
    source /etc/init.d/brcm_ethernet_helper.sh
fi
SERVICE_NAME="interface"
PID="($$)"
if [ -n "$2" -a "NULL" != "$2" ] ; then
   PARAM=`physical_ifname_to_syscfg_namespace $2`
fi
case "$1" in
   ${SERVICE_NAME}-start)
      ulog interface status "$PID Received request to $1 $2"
      iterator start $PARAM
      ;;
   ${SERVICE_NAME}-stop)
      ulog interface status "$PID Received request to $1 $2"
      iterator stop $PARAM
      ;;
   ${SERVICE_NAME}-restart)
      ulog interface status "$PID Received request to $1 $2"
      ulog interface status "$PID Calling stop"
      iterator stop $PARAM
      ulog interface status "$PID Calling start"
      iterator start $PARAM
      ;;
   *)
      echo "Usage: service-${SERVICE_NAME} [ ${SERVICE_NAME}-start | ${SERVICE_NAME}-stop | ${SERVICE_NAME}-restart]" > /dev/console
      exit 3
      ;;
esac
