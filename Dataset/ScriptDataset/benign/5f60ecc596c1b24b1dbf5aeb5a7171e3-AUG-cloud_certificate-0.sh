#!/bin/sh
echo [$0] ... > /dev/console
TROOT=`rgdb -i -g /runtime/template_root`
[ "$TROOT" = "" ] && TROOT="/etc/templates"

CLOUD_CERTS=/tmp/cloud
CLOUD_CONFIG=/var/usr/cloud
mkdir -p $CLOUD_CERTS
devconf get -n /dev/mtdblock/5 -f $CLOUD_CERTS/cloud_certificate.tar
cd $CLOUD_CERTS
tar xvf cloud_certificate.tar
mkdir -p $CLOUD_CONFIG
mv config.txt $CLOUD_CONFIG
rm cloud_certificate.tar
