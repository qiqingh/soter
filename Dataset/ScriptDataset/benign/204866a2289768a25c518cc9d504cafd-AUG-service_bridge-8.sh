   echo 0 > /proc/sys/net/bridge/bridge-nf-call-arptables
   echo 0 > /proc/sys/net/bridge/bridge-nf-call-iptables
   echo 0 > /proc/sys/net/bridge/bridge-nf-call-ip6tables
   echo 0 > /proc/sys/net/bridge/bridge-nf-filter-vlan-tagged
   echo 0 > /proc/sys/net/bridge/bridge-nf-filter-pppoe-tagged
   
   if [ "$SYSCFG_guest_enabled" = "1" ] ; then
      echo 1 > /proc/sys/net/ipv4/ip_forward
   fi
   if [ "`syscfg get gmac3_enable`" = "1" ] ; then
      ip link set fwd0 up 
      ip link set fwd0 allmulticast on
      ip link set fwd0 promisc on
      ip link set fwd1 up 
      ip link set fwd1 allmulticast on
      ip link set fwd1 promisc on
   fi
   ulog bridge status "lan interface up"
   sysevent set ${SERVICE_NAME}-errinfo
   sysevent set ${SERVICE_NAME}-status up
