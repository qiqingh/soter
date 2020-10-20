    json_load "$(objReq vlanEnable json)"
    json_select "VlanEnableP"
    json_get_vars vlanEnable
    json_select ".."

    if [ "$vlanEnable" = "0" ]; then
        return
    fi

    json_load "$(objReq vlan json)"
    json_select "VlanT"
    local Index="1"
    while json_get_type Type $Index && [ "$Type" = object ]; do
        json_select "$Index"
        json_get_vars descName enable portVID portTag portPriotity portService
        if [ "$enable" = "1" ]; then
            # only check wan port
            i=1
            vid=$(echo "$portVID" | cut -d ';' -f $i)
            tag=$(echo "$portTag" | cut -d ';' -f $i)
            pri=$(echo "$portPriotity" | cut -d ';' -f $i)
            service=$(echo $portService | cut -d ';' -f $i)
            if [ -n "$vid" -a -n "$tag" -a -n "$pri" ]; then
                VLAN_IFNAME=".$vid"
                return
            fi
        fi

	let Index=$Index+1
	json_select ".."
    done
