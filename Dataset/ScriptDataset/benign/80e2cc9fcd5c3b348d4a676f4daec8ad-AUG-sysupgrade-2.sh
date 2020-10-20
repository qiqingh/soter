	local argc=$1; shift
	local path=$1
	#Do fw upgrade
	echo $path > /tmp/fwpath
	verify_gemtek_header "$path"
	rcConf start fwupgrade
	rcConf run
