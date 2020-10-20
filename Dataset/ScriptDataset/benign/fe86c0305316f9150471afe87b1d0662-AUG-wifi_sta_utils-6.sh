    PHY_IF=$1
    if [ "$PHY_IF" = "ra0" ]; then
        echo "apcli0"
    elif [ "$PHY_IF" = "rai0" ]; then
        echo "apclii0"
    else
        echo "unknown"
    fi
