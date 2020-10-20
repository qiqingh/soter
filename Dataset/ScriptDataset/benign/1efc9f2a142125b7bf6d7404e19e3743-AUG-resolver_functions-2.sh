   HOSTNAME=`syscfg get hostname`
   LAN_IPADDR=`/sbin/ip  addr show dev br0  | grep "inet "| awk '{split($2,foo, "/"); print (foo[1]);}'`
   if [ "" != "$HOSTNAME" ] ; then
      echo "$HOSTNAME" > $HOSTNAME_FILE
      hostname $HOSTNAME
   fi
   if [ -n "$LAN_IPADDR" -a  -n "$HOSTNAME" ] ; then
      echo "$LAN_IPADDR     $HOSTNAME" > $HOSTS_FILE
   else
      echo -n > $HOSTS_FILE
   fi
   echo "127.0.0.1       localhost" >> $HOSTS_FILE
   echo "::1             localhost" >> $HOSTS_FILE
   echo "::1             ip6-localhost ip6-loopback" >> $HOSTS_FILE
   echo "fe00::0         ip6-localnet" >> $HOSTS_FILE
   echo "ff00::0         ip6-mcastprefix" >> $HOSTS_FILE
   echo "ff02::1         ip6-allnodes" >> $HOSTS_FILE
   echo "ff02::2         ip6-allrouters" >> $HOSTS_FILE
   echo "ff02::3         ip6-allhosts" >> $HOSTS_FILE
