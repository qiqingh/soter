#!/bin/sh
echo [$0] ... > /dev/console
TROOT=`rgdb -i -g /runtime/template_root`
[ "$TROOT" = "" ] && TROOT="/etc/templates"
if [ "`rgdb -i -g /wan/rg/inf:1/mode`" = "2" ]; then
	if [ "`rgdb -i -g /runtime/wan/inf:1/ip`" != "" ]; then
		mkdir -p /var/usr/cloud  > /dev/console
		cp -rf /usr/cloud_tmp/* /usr/cloud/.  > /dev/console
		/etc/templates/cloud_certificate.sh    > /dev/console	
		sh /etc/rc.d/rc.cloud & > /dev/console
	else
		xmldbc -k cloud_init
		xmldbc -t "cloud_init:3:/etc/templates/cloud_init.sh" &
		#/etc/templates/cloud_init.sh &
	fi
else
	mkdir -p /var/usr/cloud  > /dev/console
	cp -rf /usr/cloud_tmp/* /usr/cloud/.  > /dev/console
	/etc/templates/cloud_certificate.sh    > /dev/console	
	sh /etc/rc.d/rc.cloud & > /dev/console
fi
