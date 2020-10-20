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
PARAM=`utctx_cmd get wan_virtual_ifnum wan_physical_ifname lan_ethernet_virtual_ifnums lan_ethernet_physical_ifnames modem::enabled vlan_tagging::enabled`
eval $PARAM

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
if [ "$SYSCFG_vlan_tagging_enabled" = "1" ] ; then
    if [ "`syscfg get switch::router_2::port_numbers`" = "4" ] ; then
        # revert port 3, 4 PVID if needed.
        if [ "`syscfg get lan_2::port_tagging_1`" = "2" ] ; then
            et -i eth0 robowr 0x34 0x14 0x0001 2
        fi
        if [ "`syscfg get lan_3::port_tagging_1`" = "2" ] ; then
            et -i eth0 robowr 0x34 0x16 0x0001 2
        fi
        # BRCM always sets PVID when WAN port joins a VLAN, so the PVID is set to the last VLAN. Re-set it to 1.
        et -i eth0 robowr 0x34 0x18 0x0001 2 #spyder and others
    elif [ "`syscfg get switch::router_2::port_numbers`" = "0" ] ; then
        et -i eth0 robowr 0x34 0x10 0x0001 2 #f70
        if [ "`syscfg get lan_2::port_tagging_1`" = "2" ] ; then
            et -i eth0 robowr 0x34 0x16 0x0001 2
        fi
        if [ "`syscfg get lan_3::port_tagging_1`" = "2" ] ; then
            et -i eth0 robowr 0x34 0x18 0x0001 2
        fi    
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
