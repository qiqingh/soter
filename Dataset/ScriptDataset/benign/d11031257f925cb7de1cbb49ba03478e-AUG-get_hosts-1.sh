    json_load "$(objReq pcPolicy json)"
    json_select "PcPolicyT"
    local Index="1"
    while json_get_type Type $Index && [ "$Type" = object ]; do
        json_select "$Index"
        json_get_vars targetName targetMac
        echo "$targetMac $targetName" >> $OLD_HOSTS_FILE
        let Index=$Index+1
        json_select ".."
    done
