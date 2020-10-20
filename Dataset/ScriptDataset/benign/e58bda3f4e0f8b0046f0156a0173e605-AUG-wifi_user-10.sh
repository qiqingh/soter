    PHY_IF=$1
    VIR_IF=$2
    SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
    SERVER=`syscfg_get "$SYSCFG_INDEX"_radius_server`
    PORT=`syscfg_get "$SYSCFG_INDEX"_radius_port`
    KEY=`syscfg_get "$SYSCFG_INDEX"_shared`
    LAN_IP=`syscfg_get lan_ipaddr`
    set_wifi_val $VIR_IF RADIUS_Server $SERVER
    set_wifi_val $VIR_IF RADIUS_Port $PORT
    set_wifi_val $VIR_IF RADIUS_Key1 $KEY
    set_wifi_val $VIR_IF own_ip_addr $LAN_IP
    set_wifi_val $VIR_IF EAPifname br0
    set_wifi_val $VIR_IF PreAuthifname br0
    set_wifi_val $VIR_IF session_timeout_interval 0
    set_wifi_val $VIR_IF idle_timeout_interval 0
