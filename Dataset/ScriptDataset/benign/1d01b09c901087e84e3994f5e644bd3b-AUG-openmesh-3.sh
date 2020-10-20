	[ -e /usr/sbin/fw_printenv ] && install_bin /usr/sbin/fw_printenv /usr/sbin/fw_setenv
	[ -e /etc/fw_env.config ] && install_file /etc/fw_env.config
	mkdir -p $RAM_ROOT/var/lock
