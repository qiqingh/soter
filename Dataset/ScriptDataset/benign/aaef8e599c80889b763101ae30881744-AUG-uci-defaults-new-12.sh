	local name=$1
	local sysfs=$2

	json_select_object led
	
	json_select_object $1
	json_add_string name $name
	json_add_string type interface
	json_add_string sysfs $sysfs
	json_add_string interface $name
	json_select ..

	json_select ..
