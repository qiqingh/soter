#!/bin/sh
#
# MediaServer Control File written by Itzchak Rehberg
# Modified for fedora/redhat by Landon Bradshaw <phazeforward@gmail.com>
# Adapted to TwonkyMedia 3.0 by TwonkyVision GmbH
# Adapted to TwonkyMedia 4.0 by TwonkyVision GmbH
#
# This script is intended for SuSE and Fedora systems. Please report
# problems and suggestions at http://www.twonkyvision.de/mantis/
#
#
###############################################################################
#
### BEGIN INIT INFO
# Provides:       twonkymedia
# Required-Start: $network $remote_fs
# Default-Start:  3 5
# Default-Stop:   0 1 2 6
# Description:    TwonkyVision UPnP server
### END INIT INFO
#
# Comments to support chkconfig on RedHat/Fedora Linux
# chkconfig: 345 71 29
# description: TwonkyVision UPnP server
#
#==================================================================[ Setup ]===

WORKDIR="/etc"
PIDFILE=/var/run/twonky.pid

#=================================================================[ Script ]===
DAEMON=twonkymediaserver
TWONKYSRV="${WORKDIR}/${DAEMON}"

INIFILE="/etc/twonkyvision-mediaserver.ini"

cd $WORKDIR

case "$1" in
  start)
    if [ -e $PIDFILE ]; then
      echo "Process IS running. Not started again."
      exit 0
    else
      if [ ! -x "${TWONKYSRV}" ]; then
	  echo "Twonky servers not found".
	  exit $?
      fi
      echo -n "Starting $TWONKYSRV ... "
      $TWONKYSRV -inifile "${INIFILE}" -uic
    fi
  ;;
  stop)
    if [ ! -e $PIDFILE ]; then
#      echo "PID file $PIDFILE not found, stopping server anyway..."
      killall -SIGTERM ${DAEMON} 2>/dev/null
      exit 3
    else
      echo -n "Stopping Twonky MediaServer ... "
      /usr/sbin/http get http://127.0.0.1:9000/rpc/byebye >/dev/null 2>&1
      sleep 1
      PID=`cat $PIDFILE`
      kill -SIGTERM $PID 2>/dev/null
      rm -f $PIDFILE
    fi
  ;;
  reload)
    if [ ! -e $PIDFILE ]; then
      echo "PID file $PIDFILE not found, stopping server anyway..."
      killall -SIGTERM ${DAEMON} 2>/dev/null
      exit 3
    else
      echo -n "Reloading Twonky server ... "
      PID=`cat $PIDFILE`
      kill -SIGHUP $PID 2>/dev/null 2>/dev/null
    fi
  ;;
  restart)
    $0 stop
    $0 start
  ;;
  *)
    echo ""
    echo "Twonky server"
    echo "-------------"
    echo "Syntax:"
    echo "  $0 {start|stop|restart|reload}"
    echo ""
    exit 3
  ;;
esac

rc_exit
