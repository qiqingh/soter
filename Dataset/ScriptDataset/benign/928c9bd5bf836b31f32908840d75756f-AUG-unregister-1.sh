	iptables-save -t $1 2> /dev/null | grep -e "$2" |
	while read line; do
		$IPT_RUN iptables -t $1 `echo $line | sed s/"-A"/"-D"/`;
	done
