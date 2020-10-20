    lock $LOCKFILE
    if [ "$?" -eq 0 ]; then
        eval `utctx_cmd get ctf_enable parental_control_enabled`
        if [ "$SYSCFG_ctf_enable" -eq 1 ]; then
            echo 1 > /proc/net/fpbypass_ipv4_clear
            if [ "$SYSCFG_parental_control_enabled" -eq "1" ]; then
                build_bypass_for_parental_control
            fi
        fi
        unlock $LOCKFILE
    fi
