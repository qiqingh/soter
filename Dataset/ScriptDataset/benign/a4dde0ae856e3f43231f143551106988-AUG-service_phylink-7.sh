    SYSCFG_FAILED='false'
    FOO=`utctx_cmd get wan_physical_ifname hardware_vendor_name`
    eval $FOO
    if [ $SYSCFG_FAILED = 'true' ] ; then
        ulog phylink status "$PID utctx failed to get some configuration data"
        exit
    fi
