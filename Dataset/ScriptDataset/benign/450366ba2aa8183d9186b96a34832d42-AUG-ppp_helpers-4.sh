   IP_DOWN_FILENAME=/etc/ppp/ip-down
   echo -n > $IP_DOWN_FILENAME
cat << EOM >> $IP_DOWN_FILENAME
#!/bin/sh
source /etc/init.d/ulog_functions.sh
echo "[utopia][pppd ip-down] unset wan_ppp_ifname " > /dev/console
sysevent set wan_ppp_ifname
sysevent set wan_pppoe_acname
sysevent set wan_pppoe_session_id
sysevent set ppp_status down
sysevent set ppp_local_ipaddr
sysevent set ppp_remote_ipaddr
sysevent set wan_default_gateway
ulog ip-down event "sysevent set ppp_status down"
echo "[utopia][pppd ip-down] <\`date\`>" > /dev/console
EOM
   chmod 777 $IP_DOWN_FILENAME
