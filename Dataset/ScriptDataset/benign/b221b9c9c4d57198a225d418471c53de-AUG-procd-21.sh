	local script=$(readlink "$initscript")
	local name=$(basename ${script:-$initscript})

	_procd_open_trigger
	_procd_add_interface_trigger "interface.*" $1 /etc/init.d/$name reload
	_procd_close_trigger
