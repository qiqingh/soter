	local board_name="$1"
	local tar_file="$2"
	local control_length=$( (tar xf $tar_file sysupgrade-$board_name/CONTROL -O | wc -c) 2> /dev/null)
	local file_type="$(identify $2)"

	[ "$control_length" = 0 -a "$file_type" != "ubi" -a "$file_type" != "ubifs" ] && {
		echo "Invalid sysupgrade file."
		return 1
	}

	return 0
