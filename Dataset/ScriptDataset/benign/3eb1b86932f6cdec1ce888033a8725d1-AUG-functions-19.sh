	local root="${IPKG_INSTROOT}"
	local pkgname="$(basename ${1%.*})"
	local filelist="/usr/lib/opkg/info/${pkgname}.list"
	local ret=0

	add_group_and_user "${pkgname}"

	if [ -f "$root/usr/lib/opkg/info/${pkgname}.postinst-pkg" ]; then
		( . "$root/usr/lib/opkg/info/${pkgname}.postinst-pkg" )
		ret=$?
	fi

	if [ -d "$root/rootfs-overlay" ]; then
		cp -R $root/rootfs-overlay/. $root/
		rm -fR $root/rootfs-overlay/
	fi

	if [ -z "$root" ]; then
		if grep -m1 -q -s "^/etc/modules.d/" "$filelist"; then
			kmodloader
		fi

		if grep -m1 -q -s "^/etc/sysctl.d/" "$filelist"; then
			/etc/init.d/sysctl restart
		fi

		if grep -m1 -q -s "^/etc/uci-defaults/" "$filelist"; then
			[ -d /tmp/.uci ] || mkdir -p /tmp/.uci
			for i in $(grep -s "^/etc/uci-defaults/" "$filelist"); do
				( [ -f "$i" ] && cd "$(dirname $i)" && . "$i" ) && rm -f "$i"
			done
			uci commit
		fi

		rm -f /tmp/luci-indexcache
	fi

	local shell="$(command -v bash)"
	for i in $(grep -s "^/etc/init.d/" "$root$filelist"); do
		if [ -n "$root" ]; then
			${shell:-/bin/sh} "$root/etc/rc.common" "$root$i" enable
		else
			if [ "$PKG_UPGRADE" != "1" ]; then
				"$i" enable
			fi
			"$i" start
		fi
	done

	return $ret
