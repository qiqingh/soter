   EXTRA_PARAMS=""
   if [ "" != "$SYSCFG_ddns_server" ] ; then
      EXTRA_PARAMS="$EXTRA_PARAMS --server $SYSCFG_ddns_server"
   fi
   echo $EXTRA_PARAMS
