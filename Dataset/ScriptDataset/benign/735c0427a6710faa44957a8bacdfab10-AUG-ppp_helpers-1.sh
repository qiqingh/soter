   IP_PRE_UP_FILENAME=/etc/ppp/ip-pre-up
   echo -n > $IP_PRE_UP_FILENAME
cat << EOM >> $IP_PRE_UP_FILENAME
#!/bin/sh
source /etc/init.d/ulog_functions.sh
LOOP=0
while [ "\$LOOP" -lt "5" ] ; do
   if [ -f /tmp/.ip-down ] ; then
      sleep 2
      LOOP=\`expr \$LOOP + 1\`
      echo "[utopia][pppd ip-pre-up] Waiting for ip-down to finish ..." > /dev/console
   else
      break
   fi
done
echo "[utopia][pppd ip-pre-up] Parameter 1: \$1 Parameter 2: \$2 Parameter 3: \$3" > /dev/console
echo "[utopia][pppd ip-pre-up] Parameter 4: \$4 Parameter 5: \$5 Parameter 6: \$6" > /dev/console
PPP_IPADDR=\$4
PPP_SUBNET=255.255.255.255
sysevent set wan_ppp_ifname \$1
echo "[utopia][pppd ip-pre-up] sysevent set pppd_current_wan_ifname \$1" > /dev/console
sysevent set pppd_current_wan_ifname \$1
echo "[utopia][pppd ip-pre-up] sysevent set pppd_current_wan_subnet \$PPP_SUBNET" > /dev/console
sysevent set pppd_current_wan_subnet \$PPP_SUBNET
echo "[utopia][pppd ip-pre-up] sysevent set pppd_current_wan_ipaddr \$PPP_IPADDR" > /dev/console
sysevent set pppd_current_wan_ipaddr \$PPP_IPADDR
sysevent set ppp_status preup 2>&1 > /dev/console
ulog ip-preup event "sysevent set ppp_status preup"
echo "[utopia][pppd ip-pre-up] sysevent set ppp_status preup <\`date\`>" > /dev/console
EOM
   chmod 777 $IP_PRE_UP_FILENAME
