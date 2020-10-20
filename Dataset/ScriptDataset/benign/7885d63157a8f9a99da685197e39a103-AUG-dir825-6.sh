	local magic="$(get_magic_long "$1")"
	local fw_mtd=$(find_mtd_part "firmware_orig")

	case "$magic" in
	"27051956")
		if [ -n "$fw_mtd" ]; then
			# restore calibration data before downgrading to
			# the normal image
			dir825b_copy_caldata "caldata" "caldata_orig" || {
				echo "unable to restore calibration data"
				exit 1
			}
			PART_NAME="firmware_orig"
		else
			PART_NAME="firmware"
		fi
		default_do_upgrade "$ARGV"
		;;
	"43493030")
		if [ -z "$fw_mtd" ]; then
			# backup calibration data before upgrading to the
			# fat image
			dir825b_copy_caldata "caldata" "caldata_copy" || {
				echo "unable to backup calibration data"
				exit 1
			}
		fi
		dir825b_do_upgrade_combined "firmware" "$ARGV"
		;;
	esac
