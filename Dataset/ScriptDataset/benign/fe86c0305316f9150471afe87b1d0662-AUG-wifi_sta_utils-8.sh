	AP_CHANNEL_FILE=/tmp/ap_channel.txt
    SECURITY=`akm_type_detect $1 $2`
    if [ -f $AP_CHANNEL_FILE ]; then
        cat $AP_CHANNEL_FILE
    else
        echo "fail"
    fi
