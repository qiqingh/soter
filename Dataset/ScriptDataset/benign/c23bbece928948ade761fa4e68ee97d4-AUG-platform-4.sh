	# Force the creation of fw_printenv.lock
	mkdir -p /var/lock
	touch /var/lock/fw_printenv.lock

	export RAMFS_COPY_BIN="/usr/sbin/fw_printenv /usr/sbin/fw_setenv /usr/sbin/ubinfo /bin/echo ${RAMFS_COPY_BIN}"
	export RAMFS_COPY_DATA="/etc/fw_env.config /var/lock/fw_printenv.lock ${RAMFS_COPY_DATA}"
