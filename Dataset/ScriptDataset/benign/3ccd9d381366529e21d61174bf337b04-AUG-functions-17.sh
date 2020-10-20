	local name
	name=$(basename ${1%.*})
	[ -f /usr/lib/opkg/info/${name}.prerm-pkg ] && . /usr/lib/opkg/info/${name}.prerm-pkg
	for i in `cat /usr/lib/opkg/info/${name}.list | grep "^/etc/init.d/"`; do
		$i disable
		$i stop
	done
