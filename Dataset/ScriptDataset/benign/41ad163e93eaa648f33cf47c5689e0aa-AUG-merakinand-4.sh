	local board_name="$1"
	local tar_file="$2"
	local image_magic_word=`(tar xf $tar_file sysupgrade-$board_name/kernel -O 2>/dev/null | dd bs=1 count=4 skip=0 2>/dev/null | hexdump -v -n 4 -e '1/1 "%02x"')`

	# What is our kernel magic string?
	case "$board_name" in
	"mr18")
		[ "$image_magic_word" == "8e73ed8a" ] && {
			echo "pass" && return 0
		}
		;;
	"z1")
		[ "$image_magic_word" == "4d495053" ] && {
			echo "pass" && return 0
		}
		;;
	esac

	exit 1
