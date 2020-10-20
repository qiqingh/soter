#!/bin/sh

in_fw=`cat /etc/mydlink_agent/version | grep "VERSION=" | sed s/VERSION=//g`
in_mydlink=`cat /mydlink/version | grep "VERSION=" | sed s/VERSION=//g`

if [ $in_fw = $in_mydlink ]; then
	echo -n "mydlink agant is normal! version:"
	echo $in_mydlink
else
	echo -n "mydlink agant is updated to version:"
	echo $in_mydlink
	rm -rf /mydlink/*
	cp /etc/mydlink_agent/* /mydlink/
fi

