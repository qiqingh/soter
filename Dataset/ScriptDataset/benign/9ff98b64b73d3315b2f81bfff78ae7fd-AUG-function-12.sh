	brctl addbr br1
	ifconfig br1 up

	binding_ap_list=`nvram_get ApcliDBDCSsidId`
	O_IFS=$IFS
	IFS=";"
	export IFS;
	i=0
	for binding in $binding_ap_list; do
		if [ "$i" != "0" ]; then
			brctl delif br0 ra$binding
		fi
		brctl addif br$i ra$binding
		brctl addif br$i apcli$i
		i=`expr $i + 1`
	done
	IFS=$O_IFS
	export IFS;
	
