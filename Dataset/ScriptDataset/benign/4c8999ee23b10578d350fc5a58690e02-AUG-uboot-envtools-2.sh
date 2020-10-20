	local dev
	local offset
	local envsize
	local secsize
	local numsec
	config_get dev "$1" dev
	config_get offset "$1" offset
	config_get envsize "$1" envsize
	config_get secsize "$1" secsize
	config_get numsec "$1" numsec
	echo "$dev $offset $envsize $secsize $numsec" >>/etc/fw_env.config
