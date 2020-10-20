	if [ -r $1 ]; then
	# this can miss pseudo-valid files that have crap after the pattern
		cat $1 | grep -v ^$ | grep -v ^# | tail -1
	else
		echo Argument is not a readable file > /dev/stderr
		exit 1
	fi
