	if [ -r $1 ] && [ -f $1 ]; then
		cat $1 | grep -v ^$ | grep -v ^# | tail -1
	else
		echo > /dev/stderr
		echo Arg is not a readable file > /dev/stderr
		exit 1
	fi
