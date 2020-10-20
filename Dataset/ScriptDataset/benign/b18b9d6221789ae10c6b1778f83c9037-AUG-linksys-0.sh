linksys_get_target_firmware() {
	local cur_boot_part mtd_ubi0

	cur_boot_part="$(/usr/sbin/fw_printenv -n boot_part)"
	if [ -z "${cur_boot_part}" ]; then
		mtd_ubi0=$(cat /sys/devices/virtual/ubi/ubi0/mtd_num)
		case "$(grep -E "^mtd${mtd_ubi0}:" /proc/mtd | cut -d '"' -f 2)" in
		kernel|rootfs)
			cur_boot_part=1
			;;
		alt_kernel|alt_rootfs)
			cur_boot_part=2
			;;
		esac
		>&2 printf "Current boot_part='%s' selected from ubi0/mtd_num='%s'" \
			"${cur_boot_part}" "${mtd_ubi0}"
	fi

	# OEM U-Boot for EA6350v3 and EA8300; bootcmd=
	#  if test $auto_recovery = no;
	#      then bootipq;
	#  elif test $boot_part = 1;
	#      then run bootpart1;
	#      else run bootpart2;
	#  fi

	case "$cur_boot_part" in
	1)
		fw_setenv -s - <<-EOF
			boot_part 2
			auto_recovery yes
		EOF
		printf "alt_kernel"
		return
		;;
	2)
		fw_setenv -s - <<-EOF
			boot_part 1
			auto_recovery yes
		EOF
		printf "kernel"
		return
		;;
	*)
		return
		;;
	esac
}

