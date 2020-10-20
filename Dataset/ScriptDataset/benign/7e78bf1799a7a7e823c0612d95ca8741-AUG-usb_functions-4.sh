    if [ -z "$SYSCFG_ssd_trim_enabled" ]; then
        SYSCFG_ssd_trim_enabled=$(syscfg get ssd_trim_enabled)
    fi
