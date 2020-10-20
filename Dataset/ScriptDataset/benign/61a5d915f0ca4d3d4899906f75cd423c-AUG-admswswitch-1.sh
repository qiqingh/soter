	config_get ports "$CONFIG_SECTION" "eth$1"
	ports=`echo "$ports"| sed s/" "/""/g`
	ip link set dev eth$1 down
	admswconfig eth$1 ${ports}c
	ip link set dev eth$1 up
