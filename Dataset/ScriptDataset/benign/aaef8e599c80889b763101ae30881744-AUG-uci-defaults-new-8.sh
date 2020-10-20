	local name=$1
	local key=$2
	local val=$3

	json_select_object switch

	json_select_object $name
	json_add_string $key $val
	json_select ..

	json_select ..
