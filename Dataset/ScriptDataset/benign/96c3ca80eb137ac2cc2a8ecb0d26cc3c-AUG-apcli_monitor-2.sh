    json_load "$(objReq wlanBridge json)"
    json_select "WlanBridgeT"
    local Index="1"

    
    while json_get_type Type $Index && [ "$Type" = object ]; do
        local enable ssid ifname type

        json_select "$Index"
        json_get_vars ssid ifname type
        
        [ $type = "2" ] && ifname_cmd="apcli0"
        [ $type = "5" ] && ifname_cmd="apclii0"

        #let Index=$Index+1
        #json_select ".."
    done
 
