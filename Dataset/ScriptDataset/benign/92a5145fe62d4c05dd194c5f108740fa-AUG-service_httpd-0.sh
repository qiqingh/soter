#!/bin/sh
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/sbin/tr069
source /etc/init.d/ulog_functions.sh
source /etc/init.d/event_handler_functions.sh
source /etc/init.d/service_httpd/httpd_functions.sh
SERVICE_NAME="httpd"
SELF_NAME="`basename $0`"
SELF_HOME="$(dirname $(readlink -f $0))"
SELF_BIN=$SELF_HOME/service_httpd
BLOCK=$SELF_BIN/block-interfaces
PASSWORD_FILE=/tmp/.htpasswd
PMON=/etc/init.d/pmon.sh
case "$1" in
  ${SERVICE_NAME}-start)
      service_start
      ;;
  ${SERVICE_NAME}-stop)
      service_stop
      ;;
  ${SERVICE_NAME}-restart)
      service_restart
      ;;
  ${SERVICE_NAME}-status)
      do_status_lighttpd
      ;;
  lan-started)
      ulog ${SERVICE_NAME} status "${SERVICE_NAME} service, triggered by $1"
      service_restart
      ;;
  lan-stopping)
      ulog ${SERVICE_NAME} status "${SERVICE_NAME} service, triggered by $1"
      service_stop
      ;;
  *)
        echo "Usage: $SELF_NAME [${SERVICE_NAME}-start|${SERVICE_NAME}-stop|${SERVICE_NAME}-status|${SERVICE_NAME}-restart|lan-started|lan-stopping]" >&2
        exit 3
        ;;
esac
