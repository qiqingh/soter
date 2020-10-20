#!/bin/sh

#------------------------------------------------------------------
# © 2013 Belkin International, Inc. and/or its affiliates. All rights reserved.
#------------------------------------------------------------------

#------------------------------------------------------------------
# RAINIER-5849 is fixed by moving vconfig to immediately after the Ethernet
# driver in the wait script. This is a Broadcom only issue.
# 
# This script is called from the wait script to setup the vlan
#------------------------------------------------------------------

source /etc/init.d/interface_functions.sh

# get the relevant syscfg parameters
PARAM=`utctx_cmd get wan_virtual_ifnum wan_physical_ifname lan_ethernet_virtual_ifnums lan_ethernet_physical_ifnames modem::enabled vlan_tagging::enabled gmac3_enable`
eval $PARAM

# Forward STP
if [ "$SYSCFG_gmac3_enable" = "1" ] ; then
    et -i eth0 robowr 0x4 0x4 0x000000000000 6
fi

# configure Broadcom switch VLAN table
if [ "$SYSCFG_modem_enabled" = "1" ] ; then
    # create VLAN3 as early as possible so can talk to modem
    config_vlan $SYSCFG_wan_physical_ifname 3 
    ip link set vlan3 up

    if [ "`syscfg get switch::router_2::port_numbers`" = "4" ] ; then
        et -i eth0 robowr 0x05 0x81 0x0002 2
        et -i eth0 robowr 0x05 0x83 0x00200030 4
        et -i eth0 robowr 0x05 0x80 0x80 2
    
        et -i eth0 robowr 0x05 0x81 0x0003 2
        et -i eth0 robowr 0x05 0x83 0x00002030 4
        et -i eth0 robowr 0x05 0x80 0x80 2
    elif [ "`syscfg get switch::router_2::port_numbers`" = "0" ] ; then
        # F70
        et -i eth0 robowr 0x05 0x81 0x0002 2
        et -i eth0 robowr 0x05 0x83 0x00200021 4
        et -i eth0 robowr 0x05 0x80 0x80 2

        et -i eth0 robowr 0x05 0x81 0x0003 2
        et -i eth0 robowr 0x05 0x83 0x00000221 4
        et -i eth0 robowr 0x05 0x80 0x80 2
    fi
fi
# configure WAN vlan
# Backwards compatibility - create vlan2 in brideg mode only for Bentley and Carrera
if [ "" != "$SYSCFG_wan_virtual_ifnum" -a -n "`nvram get vlan${SYSCFG_wan_virtual_ifnum}ports`" ] ; then
    config_vlan $SYSCFG_wan_physical_ifname $SYSCFG_wan_virtual_ifnum
fi

# configure LAN vlan
if [ "" != "$SYSCFG_lan_ethernet_virtual_ifnums" ] ; then
    for loop in $SYSCFG_lan_ethernet_physical_ifnames
    do
        config_vlan $loop $SYSCFG_lan_ethernet_virtual_ifnums
    done
fi