   ulog "[${SERVICE_NAME}][service_init]"
   SYSCFG_FAILED='false'
   FOO=`utctx_cmd get owned_network_id owned_network_password`
   eval $FOO
   if [ $SYSCFG_FAILED = 'true' ] ; then
      ulog $SERVICE_NAME status "$PID utctx failed to get some configuration data"
      exit
   fi
