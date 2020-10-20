
	local cur_boot_part mtd_ubi0

	cur_boot_part=$(/usr/sbin/fw_printenv -n boot_part)
	if [ -z "${cur_boot_part}" ] ; then
		mtd_ubi0=$(cat /sys/devices/virtual/ubi/ubi0/mtd_num)
		case $(egrep ^mtd${mtd_ubi0}: /proc/mtd | cut -d '"' -f 2) in
		kernel1|rootfs1)
			cur_boot_part=1
			;;
		kernel2|rootfs2)
			cur_boot_part=2
			;;
		esac
		>&2 printf "Current boot_part='%s' selected from ubi0/mtd_num='%s'" \
			"${cur_boot_part}" "${mtd_ubi0}"
	fi

	cur_boot_part=`/usr/sbin/fw_printenv -n boot_part`

	case $cur_boot_part in
	1)
		fw_setenv -s - <<-EOF
			boot_part 2
			auto_recovery yes
		EOF
		printf "kernel2"
		return
		;;
	2)
		fw_setenv -s - <<-EOF
			boot_part 1
			auto_recovery yes
		EOF
		printf "kernel1"
		return
		;;
	*)
		return
		;;
	esac
