   IPV6_DOWN_FILENAME=/etc/ppp/ipv6-down
   echo -n > $IPV6_DOWN_FILENAME
cat << EOM >> $IPV6_DOWN_FILENAME
#!/bin/sh
echo "[utopia][pppd ipv6-down] <\`date\`>" > /dev/console
EOM
   chmod 777 $IPV6_DOWN_FILENAME
