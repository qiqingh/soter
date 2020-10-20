#!/bin/sh 
source /etc/init.d/ulog_functions.sh
source /etc/init.d/event_handler_functions.sh
source /etc/init.d/ipv6_functions.sh
SERVICE_NAME="dhcpv6_server"
if [ "1" = "`syscfg get ipv6_verbose_logging`" ] 
then
   LOG=/var/log/ipv6.log
else
   LOG=/dev/null
fi
SELF="$0[$$]"
EVENT=$1
if [ ! -z "$EVENT" ]
then
        VALUE=" (=`sysevent get $EVENT`)"
fi
ulog dhcpv6s status "$$: got EVENT=$EVENT$VALUE"
case "$1" in
   ${SERVICE_NAME}-start)
      service_start
      ;;
   ${SERVICE_NAME}-stop)
      service_stop
      ;;
   ${SERVICE_NAME}-restart)
      service_stop
      service_start
      ;;
   lan-status|ipv6_nameserver|ipv6_domain|ipv6_ntp_server|br0_ipv6_prefix|br1_ipv6_prefix|br0_ula_prefix|dhcp_domain)
      service_stop
      service_start
      ;;
     
   *)
      echo "Usage: $SERVICE_NAME [ ${SERVICE_NAME}-start | ${SERVICE_NAME}-stop | ${SERVICE_NAME}-restart]" > /dev/console
      echo "Received $1" > /dev/console
      exit 3
      ;;
esac
