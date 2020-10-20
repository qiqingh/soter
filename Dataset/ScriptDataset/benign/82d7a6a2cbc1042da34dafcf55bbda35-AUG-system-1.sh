    json_load "$(objReq wan json)"
    json_select WanP
    json_get_vars hostname proto
    [ $proto = 5 -o $proto = 6 -o -z $hostname ] && {
        json_load "$(objReq lan json)"
        json_select LanP
        json_get_vars routername
	hostname=$routername
    }

    MFG_MODE=$(gcontrol uenv get ManufactureMode | awk -F"=" '{print $2}')
    [ $MFG_MODE = "1" ] && {
	    hostname="MFG"
    }
    [ $MFG_MODE = "2" ] && {
	    hostname="Golden_MFG"
    }
    uci set system.@system[0].hostname="$hostname"

    json_load "$(objReq system json)"
    json_select "SystemP"
    json_get_vars debug
    json_select ".."
    if [ "$debug" = "1" ]; then
        uci set system.@system[0].conloglevel='8'
    else
        uci set system.@system[0].conloglevel='4'
    fi

    uci commit system
