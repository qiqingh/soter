	# name=$1
	# type=$2
	# itype=$3
	local cur seq

	_json_get_var cur JSON_CUR
	_json_inc JSON_SEQ seq

	local table="J_$3$seq"
	_json_set_var "U_$table" "$cur"
	export -- "${JSON_PREFIX}K_$table="
	unset "${JSON_PREFIX}S_$table"
	_json_set_var JSON_CUR "$table"
	_jshn_append "JSON_UNSET" "$table"

	_json_add_generic "$2" "$1" "$table" "$cur"
