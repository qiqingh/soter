	local file="$1"
	local magic diskdev partdev diff

	magic=$(get_magic_at "$file" 510)
	[ "$magic" != "55aa" ] && {
		echo "Failed to verify MBR boot signature."
		return 1
	}

	export_bootdevice && export_partdevice diskdev 0 || {
		echo "Unable to determine upgrade device"
	return 1
	}

	get_partitions "/dev/$diskdev" bootdisk

	#extract the boot sector from the image
	get_image "$@" | dd of=/tmp/image.bs count=1 bs=512b 2>/dev/null

	get_partitions /tmp/image.bs image

	#compare tables
	diff="$(grep -F -x -v -f /tmp/partmap.bootdisk /tmp/partmap.image)"

	rm -f /tmp/image.bs /tmp/partmap.bootdisk /tmp/partmap.image

	if [ -n "$diff" ]; then
		echo "Partition layout has changed. Full image will be written."
		ask_bool 0 "Abort" && exit 1
		return 0
	fi
