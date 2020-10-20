	mem=`expr $1 \* 1024`
	free_mem=`free | awk '/Mem/ {print $4}'`
	echo "free:$free_mem------need mem:$mem"
	if [ $free_mem -ge $mem ]; then
		return 0
	fi
	return 1
