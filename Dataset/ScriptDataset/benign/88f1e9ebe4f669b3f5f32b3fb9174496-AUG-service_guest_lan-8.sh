   ulog guest_lan status "bringing down guest lan "
   if [ ! -z $SYSCFG_wl0_guest_vap ]; then
       RADIO_24G_IF=`syscfg get wl0_user_vap`
       wl -i $RADIO_24G_IF bss -C 1 down
       wl -i $SYSCFG_wl0_guest_vap ssid "" > /dev/null  
      ip link set $SYSCFG_wl0_guest_vap down
      brctl delif $SYSCFG_guest_lan_ifname $SYSCFG_wl0_guest_vap 
   fi
   VID=$SYSCFG_guest_vlan_id
   for intf in $SYSCFG_backhaul_ifname_list
   do
      vconfig rem $intf.$VID
      ebtables -t broute -D BROUTING -i $intf -p 802.1Q --vlan-id $VID -j DROP
   done
   ip link set $SYSCFG_guest_lan_ifname down
   ip addr flush dev $SYSCFG_guest_lan_ifname
   brctl delbr $SYSCFG_guest_lan_ifname
   ulog guest_lan status "Explicitely ifconfig $SYSCFG_wl0_guest_vap down"
   ifconfig $SYSCFG_wl0_guest_vap down
   ulog guest_lan status "guest lan down"
   echo "Guest LAN is down " > /dev/console
