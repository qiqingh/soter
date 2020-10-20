	local firmware_base_addr=$( printf "%d" "$1" )
	local vmlinux_blockoffset=$( platform_get_offset "$2" uImage )
	if [ ! -n "$vmlinux_blockoffset" ]; then
		echo "can't determine uImage offset"
		return 1
	fi
	local rootfs_blockoffset=$( platform_get_offset "$2" rootfs $(( $vmlinux_blockoffset + 1 )) )
	local vmlinux_offset=$(( $vmlinux_blockoffset * $CI_BLKSZ ))
	local vmlinux_addr=$(( $firmware_base_addr + $vmlinux_offset ))
	local vmlinux_hexaddr=0x$( printf "%08x" "$vmlinux_addr" )
	if [ ! -n "$rootfs_blockoffset" ]; then
		echo "can't determine rootfs offset"
		return 1
	fi
	local rootfs_offset=$(( $rootfs_blockoffset * $CI_BLKSZ ))
	local rootfs_addr=$(( $firmware_base_addr + $rootfs_offset ))
	local rootfs_hexaddr=0x$( printf "%08x" "$rootfs_addr" )
	local vmlinux_blockcount=$(( $rootfs_blockoffset - $vmlinux_blockoffset ))
	local vmlinux_size=$(( $rootfs_offset - $vmlinux_offset ))
	local vmlinux_hexsize=0x$( printf "%08x" "$vmlinux_size" )
	local data_blockoffset=$( platform_get_offset "$2" rootfs-data $(( $rootfs_blockoffset + 1 )) )
	if [ ! -n "$data_blockoffset" ]; then
		echo "can't determine rootfs size"
		return 1
	fi
	local data_offset=$(( $data_blockoffset * $CI_BLKSZ ))
	local rootfs_blockcount=$(( $data_blockoffset - $rootfs_blockoffset ))
	local rootfs_size=$(( $data_offset - $rootfs_offset ))
	local rootfs_hexsize=0x$( printf "%08x" "$rootfs_size" )

	local rootfs_md5=$( dd if="$2" bs=$CI_BLKSZ skip=$rootfs_blockoffset count=$rootfs_blockcount 2>/dev/null | md5sum -); rootfs_md5="${rootfs_md5%% *}"
	local vmlinux_md5=$( dd if="$2" bs=$CI_BLKSZ skip=$vmlinux_blockoffset count=$vmlinux_blockcount 2>/dev/null | md5sum -); vmlinux_md5="${vmlinux_md5%% *}"
	# this needs a recent version of uboot-envtools!
	cat >/tmp/fw_env_upgrade <<EOF
vmlinux_start_addr $vmlinux_hexaddr
vmlinux_size $vmlinux_hexsize
vmlinux_checksum $vmlinux_md5
rootfs_start_addr $rootfs_hexaddr
rootfs_size $rootfs_hexsize
rootfs_checksum $rootfs_md5
bootcmd bootm $vmlinux_hexaddr
EOF

	mkdir -p /var/lock
	fw_setenv -s /tmp/fw_env_upgrade || {
		echo "failed to update U-Boot environment"
		return 1
	}
	shift
	default_do_upgrade "$@"
