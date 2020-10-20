	local root="${IPKG_INSTROOT}"
	local pkgname="$(basename ${1%.*})"
	local ret=0

	add_group_and_user "${pkgname}"

	if [ -f "$root/usr/lib/opkg/info/${pkgname}.postinst-pkg" ]; then
		( . "$root/usr/lib/opkg/info/${pkgname}.postinst-pkg" )
		ret=$?
	fi

	if [ -z "$root" ] && grep -q -s "^/etc/uci-defaults/" "/usr/lib/opkg/info/${pkgname}.list"; then
		. /lib/functions/system.sh
		[ -d /tmp/.uci ] || mkdir -p /tmp/.uci
		for i in $(sed -ne 's!^/etc/uci-defaults/!!p' "/usr/lib/opkg/info/${pkgname}.list"); do (
			cd /etc/uci-defaults
			[ -f "$i" ] && . "$i" && rm -f "$i"
		) done
		uci commit
	fi

	[ -n "$root" ] || rm -f /tmp/luci-indexcache 2>/dev/null

	if [ "$PKG_UPGRADE" != "1" ]; then
		local shell="$(which bash)"
		for i in $(grep -s "^/etc/init.d/" "$root/usr/lib/opkg/info/${pkgname}.list"); do
			if [ -n "$root" ]; then
				${shell:-/bin/sh} "$root/etc/rc.common" "$root$i" enable
			else
				"$i" enable
				"$i" start
			fi
		done
	fi

	return $ret
