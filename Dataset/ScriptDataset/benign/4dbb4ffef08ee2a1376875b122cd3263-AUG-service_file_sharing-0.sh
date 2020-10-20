#!/bin/sh
source /etc/init.d/ulog_functions.sh
source /etc/init.d/event_handler_functions.sh
source /etc/init.d/user_functions.sh
source /etc/init.d/usb_functions.sh
SERVICE_NAME="file_sharing"
SELF_NAME="`basename $0`"
pre_init () 
if [ "$SHOULD_I_START" == "started" ] ;  then
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
  mount_usb_drives)
    USTATE=`sysevent get no_usb_drives`                                     
    if [ $USTATE -gt 0 ]; then
      CURSTAT=`sysevent get file_sharing-status`
      if [ "$CURSTAT" != "starting" ] ; then
        service_stop
        service_start
      else
        echo "waiting for startup complete..."
      fi
    else
      echo "stopping file sharing due to USB complete removal"
      service_stop
      sysevent set smbd-start
    fi
    ;;
  remove_usb_drives)
    echo "receives remove_usb_drives event" > /dev/console
    CURSTAT=`sysevent get file_sharing-status`
    if [ "$CURSTAT" != "starting" ] ; then
      service_stop
      USTATE=`sysevent get no_usb_drives`
      if [ $USTATE -gt 0 ] ; then
        service_start
      else
        umount_unused_devices
      fi
    else
      echo "waiting for startup complete..." > /dev/console
    fi
    ;;
  fuadmin_pass)
    service_stop
    service_start
    ;;
  hostname)
    ;;
  dns-restart)
    HN=`syscfg get hostname`
    syscfg set ftp_server_name "$HN"
    syscfg set smb_server_name "$HN"
    syscfg set media_server_name "$HN"
    syscfg commit
    sysevent set file_sharing-restart
    ;;
  fwup_state)
    fwup_updating $3 && service_stop
    ;;
  *)
    echo "Usage: $SERVICE_NAME [ ${SERVICE_NAME}-start | ${SERVICE_NAME}-stop | ${SERVICE_NAME}-restart]" > /dev/console
    exit 3
    ;;
esac
fi
