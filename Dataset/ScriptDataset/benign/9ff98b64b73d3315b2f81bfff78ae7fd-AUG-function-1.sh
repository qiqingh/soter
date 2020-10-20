	tmp_0=`flash -r 40034 -c 1`
	tmp_1=`flash -r 40035 -c 1`
	tmp_2=`flash -r 40036 -c 1`
	tmp_3=`flash -r 40037 -c 1`
	tmp_4=`flash -r 40038 -c 1`
	tmp_5=`flash -r 40039 -c 1`
	if [ "$tmp_0" != "40034: 22" ] || [ "$tmp_1" != "40035: 34" ] || [ "$tmp_2" != "40036: 0" ] || [ "$tmp_3" != "40037: 20" ] || [ "$tmp_4" != "40038: FF" ] || [ "$tmp_5" != "40039: FF" ]; then
		flash -w 40034 -o 22
		flash -w 40035 -o 34
		flash -w 40036 -o 00
		flash -w 40037 -o 20
		flash -w 40038 -o FF
		flash -w 40039 -o FF
	fi
