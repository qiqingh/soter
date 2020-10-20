#!/bin/sh

/etc/led/lib_set_solid_after.sh 0

echo "`date` LED $0 $1 $2 $3" >> /var/log/messages

