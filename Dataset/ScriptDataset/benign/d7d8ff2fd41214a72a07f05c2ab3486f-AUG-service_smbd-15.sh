  BRIDGE_MODE=`syscfg get bridge_mode`
  if [ "$BRIDGE_MODE" ] && [ "$BRIDGE_MODE" != "0" ] ; then
    echo "starting $NMB_SERVER for bridge mode"
    service_init
    killall nmbd &> /dev/null
    $NMB_SERVER -D
  fi
