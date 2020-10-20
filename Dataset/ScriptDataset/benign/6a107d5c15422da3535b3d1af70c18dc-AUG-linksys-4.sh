	local board=$(mvebu_board_name)

	case "$board" in
	armada-385-linksys-caiman|armada-385-linksys-cobra|armada-385-linksys-shelby|armada-xp-linksys-mamba|armada-385-linksys-rango)
		export RAMFS_COPY_BIN="${RAMFS_COPY_BIN} /usr/sbin/fw_printenv /usr/sbin/fw_setenv"
		export RAMFS_COPY_BIN="${RAMFS_COPY_BIN} /bin/mkdir /bin/touch"
		export RAMFS_COPY_DATA="${RAMFS_COPY_DATA} /etc/fw_env.config /var/lock/fw_printenv.lock"

		[ -f /tmp/sysupgrade.tgz ] && {
			cp /tmp/sysupgrade.tgz /tmp/syscfg/sysupgrade.tgz
		}
		;;
	esac
