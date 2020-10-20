	[ "$#" -gt 1 ] && return 1

	case "$(get_magic_word "$1")" in
		# Combined Image
		4349)
			local md5_img=$(dd if="$1" bs=2 skip=9 count=16 2>/dev/null)
			local md5_chk=$(dd if="$1" bs=$CI_BLKSZ skip=1 2>/dev/null | md5sum -); md5_chk="${md5_chk%% *}"

			if [ -n "$md5_img" -a -n "$md5_chk" ] && [ "$md5_img" = "$md5_chk" ]; then
				return 0
			else
				echo "Invalid image. Contents do not match checksum (image:$md5_img calculated:$md5_chk)"
				return 1
			fi
		;;
		*)
			echo "Invalid image. Use combined .img files on this platform"
			return 1
		;;
	esac
