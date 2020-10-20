    objReq ddns setparam enable 0
    uci set ddns.gtkddns.enabled=$ENABLE
    uci commit ddns
