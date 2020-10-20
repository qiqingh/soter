	retry=3
	check_mem 30
	ret=$?
	if [ $ret -eq 0 ];then
		while [ $retry -gt 0 ]; do
			if curl -m 180 -o "$FW_PATH" -k "$FW_URL"; then
				if [ -s $FW_PATH ];then
					echo "Download f/w OK!" >/dev/console
					return 0	
				else
					echo "download f/w fail from Internet Server!" >/dev/console
					retry=`awk -v a=$retry 'BEGIN{print a-1}'`
					rm $FW_PATH
				fi
			else
				echo "fail to download f/w from Internet Server!" >/dev/console
				retry=`awk -v a=$retry 'BEGIN{print a-1}'`
				rm $FW_PATH
			fi
		done
	fi
	return 1
