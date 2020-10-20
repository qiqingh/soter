   echo "[utopia][l2tp] Configuring l2tp <`date`>" > /dev/console
   prepare_pppd_ip_pre_up_script
   prepare_pppd_ip_up_script
   prepare_pppd_ip_down_script
   prepare_pppd_ipv6_up_script
   prepare_pppd_ipv6_down_script
   prepare_pppd_options
   prepare_pppd_secrets
   prepare_l2tp_peers
   LAN_IFNAME=`syscfg get lan_ifname`
