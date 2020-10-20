	local tar_file="$1"
	local board_name="$(board_name)"

	# Do we need to do any platform tweaks?
	case "$board_name" in
	"mr18")
		# Check and create UBI caldata if it's invalid
		merakinand_copy_caldata "odm-caldata" "caldata"
		nand_do_upgrade $1
		;;
	"z1")
		# Check and create UBI caldata if it's invalid
		merakinand_copy_caldata "origcaldata" "caldata"
		nand_do_upgrade $1
		;;
	*)
		echo "Unsupported device $board_name";
		exit 1
		;;
	esac
