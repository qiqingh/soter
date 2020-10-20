
    current_channel=`iwconfig $1 | grep Channel | awk '{print $2}' | cut -d '=' -f 2`
    echo "current_channel:$current_channel" > /dev/console


    if [ $1 = "apcli0" ]; then
        Index=1
        index=0
    elif [ $1 = "apclii0" ]; then

        Index=2
        index=1
    fi

    json_load "$(objReq wlanBasic json)"
    json_select "WlanBasicT"

    local config_channel=0
    
    while json_get_type Type $Index && [ "$Type" = object ]; do
        local channel

        json_select "$Index"
        json_get_vars channel    
        config_channel=$channel

        #let Index=$Index+1
        #json_select ".."
        
    done

    if [ $config_channel != $current_channel ]; then
        objReq wlanBasic setparam $index channel $current_channel 
        gnvram commit

    fi
    
