	mpath="/lib/modules/`uname -r`"
	retval=-1

	mod_in_lib=`find $mpath -name "$1".ko > /dev/null 2>&1`
	#echo "find $mpath -name "$1".ko" > /dev/console
	if [ ! -z $mod_in_lib ]; then
		retval=0
	fi

	# TODO find out a way in OpenWRT
	mod_builtin=`grep $1 $mpath/modules.builtin 2>/dev/null`
	if [ ! -z "$mod_builtin" ]; then
		retval=1
	fi

	mod_inserted=`lsmod | grep $1 2>/dev/null`
	if [ ! -z "$mod_inserted" ]; then
		retval=1
	fi

	echo $retval
