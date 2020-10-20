#!/bin/sh

#
# Broadcom et command
# et -i eth0 robowr <page> <address> value
#

et -i eth0 robowr 0x00 0x18 0x1e0
et -i eth0 robowr 0x00 0x1a 0x1e0

echo "`date` LED $0 $1 $2 $3" >> /var/log/messages

