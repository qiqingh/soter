#!/bin/sh
source /etc/init.d/ulog_functions.sh
source /etc/init.d/event_handler_functions.sh
SERVICE_NAME="mediaserver"
WORKDIR1="/usr/local/MediaServer"
WORKDIR2="`dirname $0`"
PIDFILE="/tmp/config/mediaserver.pid"
APPDATA="/tmp/share/.system"
SELF_NAME="`basename $0`"
CFGDIR="/tmp/config"
CFGFILE="$CFGDIR/mediaserver.ini"
DAEMON=twonkymedia
TWONKYSRV="/usr/local/MediaServer/${DAEMON}"
LOG_FILE="/tmp/service_mediaserver.log"
echo "" > $LOG_FILE
service_init ()
if [ -x "$WORKDIR1" ]; then
WORKDIR="$WORKDIR1"
else
WORKDIR="$WORKDIR2"
fi
cd $WORKDIR
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
   ${SERVICE_NAME}-rescan)
      echo "${SERVICE_NAME} rescan contentdir"
      wget http://`syscfg get lan_ipaddr`:9999/rpc/rescan -O /dev/null
      ;;
   *)
      echo "Usage: $SERVICE_NAME [ ${SERVICE_NAME}-start | ${SERVICE_NAME}-stop | ${SERVICE_NAME}-restart]" > /dev/console
      exit 3
      ;;
esac
