#!/bin/sh

#
# Broadcom et command
# et robowr <page> <address> value
#

ethled off

echo "`date` LED $0 $1 $2 $3" >> /var/log/messages

