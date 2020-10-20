        json_load "$(objReq dhcps json)"
        json_select "DhcpsP"
        json_get_vars enable startIp endIp leaseTime dns1 dns2 dns3 wins1 maxClient

        echo "Setup DHCP server" > /dev/console
        echo "enable=          $enable" > /dev/console
        echo "startIp=         $startIp" > /dev/console
        echo "maxClient=       $maxClient" > /dev/console
        echo "leaseTime=       $leaseTime" > /dev/console
        echo "wins1=           $wins1" > /dev/console
        echo "dns1 dns2 dns3=  $dns1 $dns2 $dns3" > /dev/console
        ##Set up dhcp server
        if [ $enable = "0" ]; then
                uci set dhcp.lan.ignore="1"
		echo "" > /tmp/dhcp.leases
	else
		uci set dhcp.lan.ignore=""
        fi

        uci set dhcp.lan.start=$startIp
        if [ $leaseTime = "0" ]; then
                uci set dhcp.lan.leasetime="24h"
        else
                uci set dhcp.lan.leasetime="$leaseTime"'m'
        fi
        uci set dhcp.lan.limit=$maxClient

        local dnslist="6"
        uci delete dhcp.lan.dhcp_option
        if [ x$dns1 != x"" ]; then
                dnslist=$dnslist",$dns1"
        fi
        if [ x$dns2 != x"" ]; then
                dnslist=$dnslist",$dns2"
        fi
        if [ x$dns3 != x"" ]; then
                dnslist=$dnslist",$dns3"
        fi

        [ $dnslist == "6" ] || {
                echo "DNSList=         $dnslist" > /dev/console
                uci add_list dhcp.lan.dhcp_option=$dnslist
        }

        if [ x$wins1 != x"" ]; then
                uci add_list dhcp.lan.dhcp_option="44,$wins1"
        fi

        uci commit dhcp
