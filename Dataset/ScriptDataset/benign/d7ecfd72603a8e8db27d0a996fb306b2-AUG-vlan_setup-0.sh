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

VID_HEX=0
HEX_ARRAY="0123456789abcdef"
# The egress frame to associate WAN port need to
# carry out the VLAN tagged
# arguments are $1=lan_port, $2=vlan id
# The egress frame to associate WAN port need to
# carry out the VLAN tagged
# arguments are $1=vlan id $2=prio $3=iftagged 0/1
# The egress frame to associate WAN port need to
# carry out the VLAN tagged
action=$1
case "$action" in
    wan)
            set_wan_vlan $2 $3 $4;;
    lan_tagged)
            set_tagged_vlan $2 $3 $4;;
    lan_untagged)
            set_untagged_vlan $2 $3 $4;;
    *)
            usage ;;
esac

