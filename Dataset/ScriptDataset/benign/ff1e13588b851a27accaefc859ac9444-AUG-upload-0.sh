#!/bin/sh
#rgdb -i -s /runtime/web/upload_service none
service=`rgdb -i -g /runtime/web/upload_service`
filename=`rgdb -i -g /runtime/web/upload_filename`
test ! -z $service && echo "$service is handling" > /dev/console

if [ "$service" = "none" ]; then
	echo "This is none session" > /dev/console
elif [ "$service" = "stunnel_cert" -o $service = "stunnel_key" ]; then
	echo "Saving the external certificate or private key." > /dev/console
	spath="/sys/stunnel"
	epath="/sys/stunnel/ext_cert"
	ext_cert=`rgdb -g $epath/enable`
	if [ "$ext_cert" = "1" ]; then
		block=`rgdb -g $epath/block`
		offset=`rgdb -g $epath/offset`
		size=`rgdb -g $epath/size`
		path=`rgdb -g $spath/path`
		#echo "$block $offset $size $path" > /dev/console
		if [ -d "$path" ]; then
			cd $path/..
			tar zcf stunnel.tar.gz `basename $path`
			devconf put -n $block -o $offset -z $size -f stunnel.tar.gz
			if [ "$?" = "0" ]; then
				echo "The $filename has been saved." > /dev/console
				if [ "$service" = "stunnel_cert" ]; then
					rgdb -s /sys/stunnel/single_cert 1
					rgdb -s /sys/stunnel/certname $filename
					rgdb -i -s /runtime/sys/stunnel/ext_key_status enable
				else
					rgdb -s /sys/stunnel/single_cert 0
					rgdb -s /sys/stunnel/keyname $filename
					rgdb -i -s /runtime/sys/stunnel/ext_key_status disable
				fi
				rm -f stunnel.tar.gz
				echo `devconf dump -n $block -o $offset -z $size` > /dev/console
				/etc/scripts/misc/profile.sh put
				/etc/templates/stunnel.sh restart
			else
				echo "System Error!!! Cannot save the certificate." > /dev/console
				echo `devconf dump -n $block -o $offset -z $size` > /dev/console
			fi
		else
			echo "$path does not exist." > /dev/console
		fi
	else
		echo "Nothing to handle." > /dev/console
	fi
else
	echo "No such service." > /dev/console
fi




