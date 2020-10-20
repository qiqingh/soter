    wl0_security_mode=`nvram_get 2860 wl0_security_mode`
    wl1_security_mode=`nvram_get 2860 wl1_security_mode`
    if [ "$RadioOff_24" = "0" ] && [ "$wl0_security_mode" = "wpa2_enterprise" ]; then
        8021xd -p ra -i ra0 -d 3
    fi

    if [ "$RadioOff_5" = "0" ] && [ "$wl1_security_mode" = "wpa2_enterprise" ]; then
        8021xd -p rax -i rax0 -d 3
    fi
