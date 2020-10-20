	local script=$(readlink "$initscript")
	local name=$(basename ${script:-$initscript})
	local file

	_procd_open_trigger
	for file in "$@"; do
		_procd_add_config_trigger "config.change" "$file" /etc/init.d/$name reload
	done
	_procd_close_trigger
