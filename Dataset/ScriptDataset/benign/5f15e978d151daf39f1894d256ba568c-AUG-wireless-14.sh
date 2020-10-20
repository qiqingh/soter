
    log_info "wifi" "wireless_stop $1"

    [ "$1" = "guest" ] && {
        wireless_services_stop
        wifi down $DEV_24G
        wifi down $DEV_5G
    }

    [ "$1" = "home" ] && {
        wifi down $DEV_24G
        wifi down $DEV_5G
    }

    [ "$1" = "" ] && {
        wireless_services_stop
        wifi down
    }

    log_info "wifi" "wireless_stop end"
