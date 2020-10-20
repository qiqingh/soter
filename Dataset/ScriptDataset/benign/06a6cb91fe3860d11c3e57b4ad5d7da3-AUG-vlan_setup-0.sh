#!/bin/sh

#------------------------------------------------------------------
# © 2013 Belkin International, Inc. and/or its affiliates. All rights reserved.
#------------------------------------------------------------------

# get the relevant syscfg parameters
PARAM=`utctx_cmd get lan_ethernet_physical_ifnames lan_mac_addr wan_physical_ifname wan_mac_addr bridge_mode`
eval $PARAM

ssdk_sh debug reg set 0x04 0x80080080 4 > /dev/null 2>&1
ssdk_sh debug reg set 0xc  0x07600000 4 > /dev/null 2>&1
ssdk_sh debug reg set 0x7c 0x7e 4 > /dev/null 2>&1

ssdk_sh debug reg set 0x660 0x140301 4 > /dev/null 2>&1
ssdk_sh debug reg set 0x66c 0x140301 4 > /dev/null 2>&1
ssdk_sh debug reg set 0x678 0x140301 4 > /dev/null 2>&1
ssdk_sh debug reg set 0x684 0x140301 4 > /dev/null 2>&1
ssdk_sh debug reg set 0x690 0x140301 4 > /dev/null 2>&1
ssdk_sh debug reg set 0x69c 0x140301 4 > /dev/null 2>&1
ssdk_sh debug reg set 0x6a8 0x140301 4 > /dev/null 2>&1

#this reg is used to filter malformed ethernet attack 
#case 01748110
ssdk_sh debug reg set 0x200 0x31 4 > /dev/null 2>&1

#set vlan
ssdk_sh vlan entry create 1 > /dev/null 2>&1
ssdk_sh vlan member add 1 0 untagged > /dev/null 2>&1
ssdk_sh vlan member add 1 1 untagged > /dev/null 2>&1
ssdk_sh vlan member add 1 2 untagged > /dev/null 2>&1
ssdk_sh vlan member add 1 3 untagged > /dev/null 2>&1
ssdk_sh vlan member add 1 4 untagged > /dev/null 2>&1

ssdk_sh vlan entry create 2 > /dev/null 2>&1
if [ $SYSCFG_bridge_mode = "0" ] ; then
    ssdk_sh vlan member add 2 5 untagged > /dev/null 2>&1
else
    ssdk_sh vlan member add 1 5 untagged > /dev/null 2>&1
fi
ssdk_sh vlan member add 2 6 untagged > /dev/null 2>&1

#set port PVID
ssdk_sh portVlan defaultCVid set 0 1 > /dev/null 2>&1
ssdk_sh portVlan defaultCVid set 1 1 > /dev/null 2>&1
ssdk_sh portVlan defaultCVid set 2 1 > /dev/null 2>&1
ssdk_sh portVlan defaultCVid set 3 1 > /dev/null 2>&1
ssdk_sh portVlan defaultCVid set 4 1 > /dev/null 2>&1

if [ $SYSCFG_bridge_mode = "0" ] ; then
    ssdk_sh portVlan defaultCVid set 5 2 > /dev/null 2>&1
else
    ssdk_sh portVlan defaultCVid set 5 1 > /dev/null 2>&1
fi
ssdk_sh portVlan defaultCVid set 6 2 > /dev/null 2>&1

ssdk_sh portVlan defaultSVid set 0 1 > /dev/null 2>&1
ssdk_sh portVlan defaultSVid set 1 1 > /dev/null 2>&1
ssdk_sh portVlan defaultSVid set 2 1 > /dev/null 2>&1
ssdk_sh portVlan defaultSVid set 3 1 > /dev/null 2>&1
ssdk_sh portVlan defaultSVid set 4 1 > /dev/null 2>&1
if [ $SYSCFG_bridge_mode = "0" ] ; then
    ssdk_sh portVlan defaultSVid set 5 2 > /dev/null 2>&1
else
    ssdk_sh portVlan defaultSVid set 5 1 > /dev/null 2>&1
fi
ssdk_sh portVlan defaultSVid set 6 2 > /dev/null 2>&1

ip link set $SYSCFG_lan_ethernet_physical_ifnames down
ip link set $SYSCFG_lan_ethernet_physical_ifnames addr $SYSCFG_lan_mac_addr
ip link set $SYSCFG_lan_ethernet_physical_ifnames up

if [ $SYSCFG_bridge_mode = "0" ] ; then
    ip link set $SYSCFG_wan_physical_ifname down
    ip link set $SYSCFG_wan_physical_ifname addr $SYSCFG_wan_mac_addr
    ip link set $SYSCFG_wan_physical_ifname up
fi

#there are some garbage fdb entries produced during switch initialization, flush them
ssdk_sh fdb entry flush 0 > /dev/null 2>&1
