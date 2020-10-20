    log_info "wifi" "wireless_start $1"
    update_wireless_config

    [ "$1" = "guest" ] && {
        wifi up $DEV_24G
        wifi up $DEV_5G
    }

    [ "$1" = "home" ] && {
        wifi up $DEV_24G
        wifi up $DEV_5G
    }

    [ "$1" = "" ] && {
        wifi up
    }

    log_info "wifi" "wireless_start end"
