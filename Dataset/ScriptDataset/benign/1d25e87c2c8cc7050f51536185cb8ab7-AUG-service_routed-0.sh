#!/bin/sh
source /etc/init.d/ulog_functions.sh
source /etc/init.d/event_handler_functions.sh
source /etc/init.d/ipv6_functions.sh
SERVICE_NAME="routed"
ZEBRA_PID_FILE=/var/run/zebra.pid
RIPD_PID_FILE=/var/run/ripd.pid
ZEBRA_CONF_FILE=/etc/zebra.conf
RIPD_CONF_FILE=/etc/ripd.conf
ZEBRA_BIN_NAME=/usr/sbin/zebra
RIPD_BIN_NAME=/usr/sbin/ripd
CRON_RETRY_FILE_1=/etc/cron/cron.everyminute/zebra_ra_retry.sh
CRON_RETRY_FILE_2=/etc/cron/cron.every5minute/zebra_ra_retry.sh
CRON_RETRY_FILE_3=/etc/cron/cron.every10minute/zebra_ra_retry.sh
CRON_RETRY_FILE_4=/etc/cron/cron.hourly/zebra_ra_retry.sh
LOG=/var/log/ipv6.log
utctx_batch_get() 
if [ "$SYSCFG_bridge_mode" != "0" ] ; then
    exit 
fi
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
   wan-status)
      service_stop
      service_start
      ;;
   lan-status)
      service_stop
      service_start
      ;;
   ripd-restart)
      service_stop
      service_start
      ;;
   staticroute-restart)
      service_stop
      service_start
      ;;
   ipv6_nameserver)
      service_stop
      service_start
      ;;
   br0_ipv6_prefix)
      service_stop
      service_start
      ;;
   br0_ula_prefix)
      service_stop
      service_start
      ;;
   br1_ipv6_prefix)
      service_stop
      service_start
      ;;
   previous_br0_ipv6_prefix)
      service_stop
      service_start
      ;;
   previous_br1_ipv6_prefix)
      service_stop
      service_start
      ;;
   cron_handler)
      cron_handler $2
      ;;
   *)
      echo "Usage: $SERVICE_NAME [ ${SERVICE_NAME}-start | ${SERVICE_NAME}-stop | ${SERVICE_NAME}-restart]" > /dev/console
      exit 3
      ;;
esac
