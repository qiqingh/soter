    SYSCFG_INDEX=$1
    if [ "wl0" = "$SYSCFG_INDEX" ]; then
        8021xd -p ra -i ra0 -d 3
    else
        8021xd -p rai -i rai0 -d 3
    fi
