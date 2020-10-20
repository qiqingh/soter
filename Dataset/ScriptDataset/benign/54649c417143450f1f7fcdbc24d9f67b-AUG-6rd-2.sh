	IFS=':'; set $1; unset IFS
	echo "$(printf %02x $((0x$1 ^ 2)))$2:${3}ff:fe$4:$5$6"
