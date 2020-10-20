	#if [ -e $LED_CTRL ]; then   
		#echo "pwm=off" > $LED_CTRL
		#sleep $1
		#echo "pwm=on" > $LED_CTRL
		#sleep $2
	#fi
        $LED off
	sleep $1
        $LED on
	sleep $2

