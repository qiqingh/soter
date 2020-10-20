#!/bin/sh
source /etc/init.d/ulog_functions.sh
SERVICE_NAME="wl_mac_filter"
SELF_NAME="`basename $0`"
IF_NAME_0=`syscfg get wl0_user_vap`
IF_NAME_1=`syscfg get wl1_user_vap`
IF_NAME_2=`syscfg get wl0_guest_vap`
IF_LIST="$IF_NAME_0 $IF_NAME_1 $IF_NAME_2"
CURRENT_SETTING=`syscfg get wl_access_restriction`
MAC_ENTRIES=`syscfg get wl_mac_filter`
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
  mac_filter_changed)
      service_stop
      service_start
      ;;
  *)
      echo "Usage: $SELF_NAME [${SERVICE_NAME}-start|${SERVICE_NAME}-stop|${SERVICE_NAME}-restart]|mac_filter_changed" >&2
      exit 3
      ;;
esac
