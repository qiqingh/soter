    SYSCFG_FAILED='false'
    eval `utctx_cmd get $1`
    if [ $SYSCFG_FAILED = 'true' ] ; then
        echo "Call failed"
        return 1
    fi
