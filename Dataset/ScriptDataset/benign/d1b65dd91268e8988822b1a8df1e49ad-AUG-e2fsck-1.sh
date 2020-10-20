	set -o pipefail
	e2fsck -p "$device" 2>&1 | logger -t "fstab: e2fsck ($device)"
	local status="$?"
	set +o pipefail
	case "$status" in
		0|1) ;; #success
		2) reboot;;
		4) echo "e2fsck ($device): Warning! Uncorrected errors."| logger -t fstab
			return 1
			;;
		*) echo "e2fsck ($device): Error $status. Check not complete."| logger -t fstab;;
	esac
	return 0
