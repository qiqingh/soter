	local root="${IPKG_INSTROOT}"
	local pkgname="$(basename ${1%.*})"
	local ret=0

	if [ -f "$root/usr/lib/opkg/info/${pkgname}.prerm-pkg" ]; then
		( . "$root/usr/lib/opkg/info/${pkgname}.prerm-pkg" )
		ret=$?
	fi

	local shell="$(command -v bash)"
	for i in $(grep -s "^/etc/init.d/" "$root/usr/lib/opkg/info/${pkgname}.list"); do
		if [ -n "$root" ]; then
			${shell:-/bin/sh} "$root/etc/rc.common" "$root$i" disable
		else
			if [ "$PKG_UPGRADE" != "1" ]; then
				"$i" disable
			fi
			"$i" stop
		fi
	done

	return $ret
