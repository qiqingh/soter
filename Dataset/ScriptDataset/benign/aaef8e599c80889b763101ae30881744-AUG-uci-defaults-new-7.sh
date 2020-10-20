	local name=$1
	local reset=$2
	local enable=$3

	json_select_object switch

	json_select_object $name
	json_add_boolean enable $enable
	json_add_boolean reset $reset
	json_select ..

	json_select ..
