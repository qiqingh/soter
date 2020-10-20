#!/bin/sh
echo [$0]: $1 ... > /dev/console
if [ "$1" = "start" ]; then
    service LOGD restart &
    service LOGD alias DEVICE.LOG
    service EMAIL restart &
else
	service LOGD stop
fi
