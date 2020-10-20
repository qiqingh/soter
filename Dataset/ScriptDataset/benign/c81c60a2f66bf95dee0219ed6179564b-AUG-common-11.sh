	local cmdline bootdisk rootpart uuid blockdev uevent line
	local MAJOR MINOR DEVNAME DEVTYPE

	if read cmdline < /proc/cmdline; then
		case "$cmdline" in
			*block2mtd=*)
				bootdisk="${cmdline##*block2mtd=}"
				bootdisk="${bootdisk%%,*}"
			;;
			*root=*)
				rootpart="${cmdline##*root=}"
				rootpart="${rootpart%% *}"
			;;
		esac

		case "$bootdisk" in
			/dev/*)
				uevent="/sys/class/block/${bootdisk##*/}/uevent"
			;;
		esac

		case "$rootpart" in
			PARTUUID=[a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9]-[a-f0-9][a-f0-9])
				uuid="${rootpart#PARTUUID=}"
				uuid="${uuid%-[a-f0-9][a-f0-9]}"
				for blockdev in $(find /dev -type b); do
					set -- $(dd if=$blockdev bs=1 skip=440 count=4 2>/dev/null | hexdump -v -e '4/1 "%02x "')
					if [ "$4$3$2$1" = "$uuid" ]; then
						uevent="/sys/class/block/${blockdev##*/}/uevent"
						break
					fi
				done
			;;
			/dev/*)
				uevent="/sys/class/block/${rootpart##*/}/../uevent"
			;;
		esac

		if [ -e "$uevent" ]; then
			while read line; do
				export -n "$line"
			done < "$uevent"
			export BOOTDEV_MAJOR=$MAJOR
			export BOOTDEV_MINOR=$MINOR
			return 0
		fi
	fi

	return 1
