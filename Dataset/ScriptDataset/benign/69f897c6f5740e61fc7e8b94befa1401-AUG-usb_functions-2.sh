    if [ -z "$SYSCFG_hw_revision" ]; then
        SYSCFG_hw_revision=`syscfg get device::hw_revision`
    fi
