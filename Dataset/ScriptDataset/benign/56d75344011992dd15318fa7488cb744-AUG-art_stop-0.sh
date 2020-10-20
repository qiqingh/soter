#!/bin/sh

	  echo Stop wireless interface....> /dev/console
	  kill  `ps | grep /lib/modules/mdk_client.out | grep -v grep | cut -b 1-5` > /dev/console
	  rmmod /lib/modules/art.ko
    rm -rf /dev/dk0 
