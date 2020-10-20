   SYSCFG_FAILED='false'
   FOO=`utctx_cmd get UsbPortCount`
   eval $FOO
   if [ $SYSCFG_FAILED = 'true' ] ; then
      ulog usb status "$PID utctx failed to get some configuration data"
      exit
   fi
