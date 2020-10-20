	local opt=$1
	echo "turn $opt USB!" > /dev/console
	if [ "$opt" = "on" ];then
                echo 1 >/sys/class/leds/usb_en/brightness
	elif [ "$opt" = "off" ];then
                echo 0 >/sys/class/leds/usb_en/brightness
	fi
