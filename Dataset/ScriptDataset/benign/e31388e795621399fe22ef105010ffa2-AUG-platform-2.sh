	local part
	for part in "${1%:*}" "${1#*:}"; do
		case "$part" in
			vmlinux.bin.l7|kernel|linux)
				echo "$part"
				break
			;;
		esac
	done
