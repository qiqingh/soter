	hfsfsck "$device" 2>&1 | logger -t "fstab: hfsfsck ($device)"
	local status="$?"
	case "$status" in
		0) ;; #success
		4) reboot;;
		8) echo "hfsfsck ($device): Warning! Uncorrected errors."| logger -t fstab
			return 1
			;;
		*) echo "hfsfsck ($device): Error $status. Check not complete."| logger -t fstab;;
	esac
	return 0
