   FIRST_START=`sysevent get file-sharing-first-start`
   BRIDGE_MODE=`syscfg get bridge_mode`
   if [ "$FIRST_START" != "" ] || [ "$BRIDGE_MODE" == "1" ] ; then
     pre_init
     USB_COUNT=`ls /dev/ | grep -r "sd[a-z][0-9]*" | uniq | wc -l`
     if [ ! "$USB_COUNT" ] ; then
        USB_COUNT=0
     fi
     if [ $USB_COUNT -lt 1 ] ; then
       SMB_ENA=`syscfg get smb_enabled`
       FTP_ENA=0
       MED_ENA=0
       SERVICES=0
     else
       service_init
       echo "$USB_COUNT usb storage drives detected..."
       if [ $USB_COUNT -gt 0 ] ; then
        check_mounted_usb_drives
       fi
       
       SMB_ENA=`syscfg get smb_enabled`
       FTP_ENA=`syscfg get ftp_enabled`
       MED_ENA=`syscfg get media_server_enabled`
       FTP_ENA="1"
     fi
    
     if [ "$SMB_ENA" == "1" ] ; then
        /etc/init.d/service_smbd.sh smbd-start
     fi
     if [ "$FTP_ENA" == "1"  ] ; then
        /etc/init.d/service_vsftpd.sh vsftpd-start
     fi
     if [ "$MED_ENA" == "1"  ] && [ -f "/etc/init.d/service_mediaserver.sh" ] ; then
        /etc/init.d/service_mediaserver.sh mediaserver-restart
     fi
     sysevent set file_sharing-status started
     sysevent set file-sharing-first-start "OK"
  else
    /etc/init.d/share_parser.sh
    sleep 30
    sysevent set file-sharing-first-start "OK"
    sysevent set file_sharing-restart
  fi
