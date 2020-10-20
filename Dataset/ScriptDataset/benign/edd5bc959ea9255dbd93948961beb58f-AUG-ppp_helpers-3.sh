   IPV6_UP_FILENAME=/etc/ppp/ipv6-up
   IPV6_LOG_FILE=/var/log/ipv6.log
   echo -n > $IPV6_UP_FILENAME
cat << EOM >> $IPV6_UP_FILENAME
#!/bin/sh
source /etc/init.d/ulog_functions.sh
echo "[utopia][pppd ipv6-up] Congratulations PPPoE IPv6 is up" > /dev/console
echo "[utopia][pppd ipv6-up] Interface: \$1 tty device name: \$2 tty device speed: \$3" > /dev/console
echo "[utopia][pppd ipv6-up] Local link local address: \$4 Remote link local address: \$5 ipparam value: \$6" > /dev/console
IPV6_ROUTER_ADV=\`syscfg get router_adv_provisioning_enable\`
if [ "1" = "\$IPV6_ROUTER_ADV" ] ; then
   echo 2 > /proc/sys/net/ipv6/conf/\$1/accept_ra    # Accept RA even when forwarding is enabled
   echo 1 > /proc/sys/net/ipv6/conf/\$1/accept_ra_defrtr # Accept default router (metric 1024)
   echo 1 > /proc/sys/net/ipv6/conf/\$1/accept_ra_pinfo # Accept prefix information for SLAAC
   echo 1 > /proc/sys/net/ipv6/conf/\$1/autoconf     # Do SLAAC
fi
ip -6 route add default via \$5 dev \$1
ulog ip-up event "ip -6 route add default via \$5 dev \$1"
echo "[utopia][pppd ipv6-up] <\`date\`>" > /dev/console
EOM
   chmod 777 $IPV6_UP_FILENAME
