#!/bin/sh

/etc/led/blink.sh

echo "`date` LED $0 $1 $2 $3" >> /var/log/messages

