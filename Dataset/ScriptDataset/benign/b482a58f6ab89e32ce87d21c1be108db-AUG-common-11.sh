	local cmdline uuid disk uevent line
	local MAJOR MINOR DEVNAME DEVTYPE

	if read cmdline < /proc/cmdline; then
		case "$cmdline" in
			*block2mtd=*)
				disk="${cmdline##*block2mtd=}"
				disk="${disk%%,*}"
			;;
			*root=*)
				disk="${cmdline##*root=}"
				disk="${disk%% *}"
			;;
		esac

		case "$disk" in
			PARTUUID=[a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9]-02)
				uuid="${disk#PARTUUID=}"
				uuid="${uuid%-02}"
				for disk in $(find /dev -type b); do
					set -- $(dd if=$disk bs=1 skip=440 count=4 2>/dev/null | hexdump -v -e '4/1 "%02x "')
					if [ "$4$3$2$1" = "$uuid" ]; then
						uevent="/sys/class/block/${disk##*/}/uevent"
						break
					fi
				done
			;;
			/dev/*)
				uevent="/sys/class/block/${disk##*/}/uevent"
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
