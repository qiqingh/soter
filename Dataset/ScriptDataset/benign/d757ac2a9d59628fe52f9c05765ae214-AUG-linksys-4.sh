	export RAMFS_COPY_BIN="${RAMFS_COPY_BIN} /usr/sbin/fw_printenv /usr/sbin/fw_setenv"
	export RAMFS_COPY_BIN="${RAMFS_COPY_BIN} /bin/mkdir /bin/touch"
	export RAMFS_COPY_DATA="${RAMFS_COPY_DATA} /etc/fw_env.config /var/lock/fw_printenv.lock"

