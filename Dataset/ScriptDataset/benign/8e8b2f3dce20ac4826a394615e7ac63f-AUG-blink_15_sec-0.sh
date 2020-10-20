#!/bin/sh

/etc/led/run_15_sec_blink.sh &

echo "`date` LED $0 $1 $2 $3" >> /var/log/messages

