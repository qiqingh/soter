#!/bin/sh
source /etc/init.d/event_handler_functions.sh
source /etc/init.d/ulog_functions.sh
SERVICE_NAME="guardian"
SELF_NAME="`basename $0`"
BIN=guardian
APP=/usr/bin/${BIN}
_STATUS="sysevent get ${SERVICE_NAME}-status"
_PID="pidof ${BIN}"
PID_FILE=/var/run/${BIN}.pid
PMON=/etc/init.d/pmon.sh
  ${SERVICE_NAME}-start)
      if [ "`syscfg get bridge_mode`" = "0" ] && [ "`sysevent get lan-status`" != "started" ]; then
          ulog wlan status "LAN is not started. So ignore the request"
          exit 0
      fi
      service_start
      ;;
  ${SERVICE_NAME}-stop)
      service_stop
      ;;
  ${SERVICE_NAME}-restart)
      if [ "`syscfg get bridge_mode`" = "0" ] && [ "`sysevent get lan-status`" != "started" ]; then
          ulog wlan status "LAN is not started. So ignore the request"
          exit 0
      fi
      ulog ${SERVICE_NAME} status "${SERVICE_NAME} guardian-restart sequence initiated"
      service_stop
      service_start
      ulog ${SERVICE_NAME} status "${SERVICE_NAME} guardian-restart sequence complete"
      ;;
  lan-status)
      LAN_STATUS=`sysevent get lan-status`
      if [ "started" == "${LAN_STATUS}" ] ; then
          service_start
      elif [ "stopped" == "${LAN_STATUS}" ] ; then
          service_stop
      fi
      ;;
  lan-restart)
      ulog ${SERVICE_NAME} status "${SERVICE_NAME} lan-restart sequence initiated"
      service_stop
      ulog ${SERVICE_NAME} status "${SERVICE_NAME} waiting for end state on lan"
      wait_till_end_state lan
      service_start
      ulog ${SERVICE_NAME} status "${SERVICE_NAME} lan-restart sequence complete"
      ;;
  *)
      echo "Usage: $SELF_NAME [${SERVICE_NAME}-start|${SERVICE_NAME}-stop|${SERVICE_NAME}-restart|lan-status|lan-restart]" >&2
      ;;
esac
