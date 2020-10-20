   SYSCFG_UsbPortCount=`syscfg get UsbPortCount`
   [ -z "$SYSCFG_UsbPortCount" ] && return
   for i in `seq 1 $SYSCFG_UsbPortCount`
   do
      unmount_storage_drive $i
      stop_usb_port $i
   done
   
   rm_storage_drivers
   rm_virtualusb_drivers
   sysevent set ${SERVICE_NAME}-status stopped
