#!/bin/sh
echo [$0] ... > /dev/console
TROOT=`rgdb -i -g /runtime/template_root`
[ "$TROOT" = "" ] && TROOT="/etc/templates"
if [ "$1" != "" ]; then
echo "Don't power off or reboot!" > /dev/console
devconf put -n /dev/mtdblock/5 -f $1
reboot
else
echo "usage: cloud_certificate_put.sh [certificate path]" > /dev/console
fi
