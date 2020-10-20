	local root="${IPKG_INSTROOT}"
	local name

	name=$(basename ${1%.*})
	[ -f "$root/usr/lib/opkg/info/${name}.prerm-pkg" ] && . "$root/usr/lib/opkg/info/${name}.prerm-pkg"

	local shell="$(which bash)"
	for i in `cat "$root/usr/lib/opkg/info/${name}.list" | grep "^/etc/init.d/"`; do
		if [ -n "$root" ]; then
			${shell:-/bin/sh} "$root/etc/rc.common" "$root$i" disable
		else
			if [ "$PKG_UPGRADE" != "1" ]; then
				"$i" disable
			fi
			"$i" stop || /bin/true
		fi
	done
