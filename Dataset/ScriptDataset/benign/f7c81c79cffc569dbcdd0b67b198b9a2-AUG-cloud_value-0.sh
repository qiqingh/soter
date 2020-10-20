#!/bin/sh
echo [$0] $1 $2 ... > /dev/console
if [ "`rgdb -g /cloud/enable`" = "0" ]; then
   /etc/templates/cloud_manager_switch.sh tocm
else
    /etc/templates/cloud_manager_switch.sh tolm
fi

