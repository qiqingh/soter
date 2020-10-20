	local board_name="$1"
	local tar_file="$2"
	local control_length=`(tar xf $tar_file sysupgrade-$board_name/CONTROL -O | wc -c) 2> /dev/null`
	local file_type="$(identify_tar $2 sysupgrade-$board_name/root)"
	local kernel_magic="$(merakinand_do_kernel_check $1 $2)"

	case "$board_name" in
	"mr18"|\
	"z1")
		[ "$control_length" = 0 -o "$file_type" != "squashfs" -o "$kernel_magic" != "pass" ] && {
			echo "Invalid sysupgrade file for $board_name"
			return 1
		}
		;;
	*)
		echo "Unsupported device $board_name";
		return 1
		;;
	esac

	return 0
