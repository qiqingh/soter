	offsetcount=0
	magiclong="x"
	if [ -n "$3" ]; then
		offsetcount=$3
	fi
	while magiclong=$( get_magic_long_at "$1" "$offsetcount" ) && [ -n "$magiclong" ]; do
		case "$magiclong" in
			"2705"*)
				# U-Boot image magic
				if [ "$2" = "uImage" ]; then
					echo $offsetcount
					return
				fi
			;;
			"68737173"|"73717368")
				# SquashFS
				if [ "$2" = "rootfs" ]; then
					echo $offsetcount
					return
				fi
			;;
			"deadc0de"|"19852003")
				# JFFS2 empty page
				if [ "$2" = "rootfs-data" ]; then
					echo $offsetcount
					return
				fi
			;;
		esac
		offsetcount=$(( $offsetcount + 1 ))
	done
