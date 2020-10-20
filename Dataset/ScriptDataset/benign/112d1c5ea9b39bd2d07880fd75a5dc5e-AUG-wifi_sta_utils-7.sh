    PHY_IF=$1
    CHANNEL=`iwconfig $PHY_IF | grep "Channel=" | awk -F "Channel=" '{print $2}' | cut -d' ' -f 1`
    echo "$CHANNEL"
