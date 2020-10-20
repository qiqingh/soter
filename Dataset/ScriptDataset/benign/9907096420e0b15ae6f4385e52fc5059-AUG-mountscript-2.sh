   PART=$1
   
   echo $SERVICE_NAME $PID checking partition $PART
   
   for fs_name in $ufsd_supported_fs
   do
      check_fs $fs_name $PART; RET_CODE=$?
      if [ ! "$RET_CODE" = "4" ] ; then
         break
      fi
   done
    
   case $RET_CODE in
      0)
         return 0
      ;;
      2)    
         ulog usb_mountscript status "$PID cannot find the chk utility"
      ;;
      3) 
         ulog usb_mountscript status "$PID bad partition $PART"
         return 1
      ;;
      4) 
         ulog usb_mountscript status "$PID unsupported file system on $PART"
         sysevent set ${SERVICE_NAME}-status error
         sysevent set ${SERVICE_NAME}-errinfo "Unsupported filesystem error"
         return 3
      ;;
      *)
      ;;
   esac
   
   return 2 
