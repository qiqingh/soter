    SetupDdns
    json_load "$(ifstatus wan)"
    json_get_var DEVICE device

    /usr/sbin/inadyn -f $CONFIG -l info -i $DEVICE
    ddns_log "start ddns service"
