        RET_VAL=$(sysevent get led_timeout_sec)
        if [ -z ${RET_VAL} ]; then
		RET_VAL=0
	fi

        echo ${RET_VAL}
