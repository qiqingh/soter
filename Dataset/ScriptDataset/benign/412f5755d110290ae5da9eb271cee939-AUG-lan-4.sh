        ###Delete all reserved items
        while uci -q delete dhcp.@host[0]; do :; done

        ###Setup static reserved
        echo "Setup DCHP Reserved" > /dev/console
        json_load "$(objReq dhcpStatic json)"
        json_select "DhcpStaticT"
        local Index="1"
        while json_get_type Type $Index && [ "$Type" = object ]; do
                json_select "$Index"
                json_get_vars hostname mac assignedIp
                echo "[$Index  $hostname] mac ip =      $mac  $assignedIp" > /dev/console
                let Index=$Index+1
                json_select ".."
                uci add dhcp host
                uci set dhcp.@host[-1].name=$hostname
                uci set dhcp.@host[-1].mac=$mac
                uci set dhcp.@host[-1].ip=$assignedIp
        done
        uci commit
