   echo "[utopia][pppoe] Configuring pppoe <`date`>" > /dev/console
   prepare_pppd_ip_pre_up_script
   prepare_pppd_ip_up_script
   prepare_pppd_ip_down_script
   prepare_pppd_ipv6_up_script
   prepare_pppd_ipv6_down_script
   prepare_pppd_options
   prepare_pppd_secrets
   prepare_pppoe_peers
