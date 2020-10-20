    if [ "wl0" = "$SYSCFG_INDEX" ]; then
        add_wifi_cmd "iwpriv $PHY_IF set tpc_duty=100:085:050:020"
        add_wifi_cmd "iwpriv $PHY_IF set tpc=1:1:1:123:114:125:0060:1"
    else
        add_wifi_cmd "iwpriv $PHY_IF set tpc_duty=100:070:060:010"
        add_wifi_cmd "iwpriv $PHY_IF set tpc=1:1:1:123:117:125:0060:1"
    fi
