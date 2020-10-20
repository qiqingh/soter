	local upgrade_file="$1"

	local pn
	local found=""
	local err

	case "$(get_magic_long "$upgrade_file")" in

	"27051956")	# U-Boot Image Magic

		for pn in "nor_${PART_NAME}" "$PART_NAME" ; do		# firmware
			if [ "$(find_mtd_index "$pn")" ] ; then
				PART_NAME="$pn"
				found="yes"
				break
			fi
		done
		if [ "$found" = "yes" ] ; then
			>&2 echo "Running NOR upgrade"
			default_do_upgrade "$upgrade_file"
			# At this time, default_do_upgrade() exits on error
			type set_next_boot_nor >/dev/null && set_next_boot_nor
		else
			>&2 echo "ERROR: UPGRADE FAILED: Unable to locate '$PART_NAME' or 'nor_${PART_NAME}'"
			exit 1
		fi
		;;

	*)	# otherwise a file that nand_do_upgrade can process

		for pn in "nand_${CI_KERNPART}" "$CI_KERNPART" ; do	# kernel
			if [ "$(find_mtd_index "$pn")" ] ; then
				CI_KERNPART="$pn"
				break
			fi
		done
		for pn in "nand_${CI_UBIPART}" "$CI_UBIPART" ; do	# ubi
			if [ "$(find_mtd_index "$pn")" ] ; then
				CI_UBIPART="$pn"
				break
			fi
		done
		for pn in "nand_${CI_ROOTPART}" "$CI_ROOTPART" ; do	#rootfs
			if [ "$(find_mtd_index "$pn")" ] ; then
				CI_ROOTPART="$pn"
				break
			fi
		done
		>&2 echo "Running NAND upgrade"
		# TODO: change order when NAND upgrade offers return
		type set_next_boot_nand >/dev/null && set_next_boot_nand
		nand_do_upgrade "$upgrade_file"
		;;
	esac
