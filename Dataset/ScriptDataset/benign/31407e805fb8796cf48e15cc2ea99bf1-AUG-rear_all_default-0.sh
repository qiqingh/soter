#!/bin/sh

#
# Broadcom et command
# et robowr <page> <address> value
#

et robowr 0x00 0x18 0x1ff
et robowr 0x00 0x1a 0x1ff


echo "`date` LED $0 $1 $2 $3" >> /var/log/messages

