check_buffalo_enc() {
	[ -x /sbin/buffalo-decode ] || return 1

	case "$(cat /proc/device-tree/model)" in
		*WXR-1750DHP) product=WXR-1750DHP;;
		*WZR-1750DHP) product=WZR-1750DHP;;
		*WXR-1900DHP) product=WXR-1900DHP;;
		*) return 1;;
	esac

	/sbin/buffalo-decode -i "$1" -o "/tmp/upg.img" -p "$product" || return 1
	if [ $TEST -eq 1 ]; then
		rm -f "/tmp/upg.img"
		return 0
	fi
	tail -n +3 "/tmp/upg.img" > "$1"
	rm -f "/tmp/upg.img"
	export SAVE_CONFIG=0
}

if [ $TEST -eq 1 ]; then
	sysupgrade_image_post_check="$sysupgrade_image_check"
	sysupgrade_image_check=verify_signature
else
	sysupgrade_image_check="verify_signature $sysupgrade_image_check"
fi
