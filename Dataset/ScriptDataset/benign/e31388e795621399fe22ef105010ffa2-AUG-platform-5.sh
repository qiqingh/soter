	local board=$(board_name)
	local magic="$(get_magic_word "$1")"
	local partitions=$(platform_find_partitions)
	local kernelpart=$(platform_find_kernelpart "${partitions#*:}")
	local kern_part_size=0x$(platform_find_part_size "$kernelpart")
	local kern_length=0x$(dd if="$1" bs=2 skip=1 count=4 2>/dev/null)

	[ "$#" -gt 1 ] && return 1

	case "$board" in
	avila | cambria )
		[ "$magic" != "4349" ] && {
			echo "Invalid image. Use *-sysupgrade.bin files on this board"
			return 1
		}

		kern_length_b=$(printf '%d' $kern_length)
		kern_part_size_b=$(printf '%d' $kern_part_size)
		if [ $kern_length_b -gt $kern_part_size_b ]; then
			echo "Invalid image. Kernel size ($kern_length) exceeds kernel partition ($kern_part_size)"
			return 1
		fi

		local md5_img=$(dd if="$1" bs=2 skip=9 count=16 2>/dev/null)
		local md5_chk=$(dd if="$1" bs=$CI_BLKSZ skip=1 2>/dev/null | md5sum -); md5_chk="${md5_chk%% *}"
		if [ -n "$md5_img" -a -n "$md5_chk" ] && [ "$md5_img" = "$md5_chk" ]; then
			return 0
		else
			echo "Invalid image. Contents do not match checksum (image:$md5_img calculated:$md5_chk)"
			return 1
		fi

		return 0
		;;
	esac

	echo "Sysupgrade is not yet supported on $board."
	return 1
