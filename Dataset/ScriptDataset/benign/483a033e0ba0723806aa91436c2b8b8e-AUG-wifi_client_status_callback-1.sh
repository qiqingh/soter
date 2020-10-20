    if [ `syscfg_get device::cert_region` = "EU" ]; then
        if [ "$PHY_IF" = "rai0" -o "$PHY_IF" = "rai1" ]; then
            echo "SKU is EU and 5G interface has STA connect/disconnect, issue CE RED test command!" > /dev/console
            iwpriv rai0 set RED_TEST=1
        fi
    fi
