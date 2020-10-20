    json_load "$(objReq wlanGuest json)"
    json_select "WlanGuestT"

    local Index="1" gst_enable_2g=0 gst_enable_5g=0
    while json_get_type Type $Index && [ "$Type" = object ]; do
        local enable ssid type 
        json_select "$Index"
        json_get_vars enable type    
        [ $type = "2" -a  $enable = "1" ] && gst_enable_2g=1
        [ $type = "5" -a  $enable = "1" ] && gst_enable_5g=1
        let Index=$Index+1
        json_select ".."
    done
    
    if [ "$gst_enable_2g" = "1" -o "$gst_enable_5g" = "1" ]; then
        uci set dhcp.guest=dhcp
        uci set dhcp.guest.interface=guest
        uci set dhcp.guest.start=50
        uci set dhcp.guest.limit=50 
        uci set dhcp.guest.leasetime='1h' 
        uci commit dhcp
    else
       uci delete dhcp.guest
       uci commit dhcp
    fi
    
