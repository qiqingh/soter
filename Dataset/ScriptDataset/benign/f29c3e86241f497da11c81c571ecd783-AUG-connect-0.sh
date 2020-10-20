#!/bin/sh

export APN="internet.eplus.de"
export USR="eplus"
export PAS="gprs"
export PIN="0000"
#export APN="web.vodafone.de"
#export USR=""
#export PAS=""



DEVICE=/dev/usb/tts/0

TMPFIL=/tmp/connect.$$

case "$1" in
	up)
		up
		;;
	down)
		down
		;;
	restart)
		down
		up
		;;
	init)
		init
		;;
	*)
		usage
		;;
esac

