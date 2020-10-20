	local pkgname rusers ret
	ret=0
	pkgname=$(basename ${1%.*})
	rusers=$(grep "Require-User:" ${IPKG_INSTROOT}/usr/lib/opkg/info/${pkgname}.control)
	[ -n "$rusers" ] && {
		local user group uid gid
		for a in $(echo $rusers | sed "s/Require-User://g"); do
			user=""
			group=""
			for b in $(echo $a | sed "s/:/ /g"); do
				local ugname ugid

				ugname=$(echo $b | cut -d= -f1)
				ugid=$(echo $b | cut -d= -f2)

				[ -z "$user" ] && {
					user=$ugname
					uid=$ugid
					continue
				}

				gid=$ugid
				[ -n "$gid" ] && {
					group_exists $ugname || group_add $ugname $gid
				}

				[ -z "$gid" ] && {
					group_add_next $ugname
					gid=$?
				}

				[ -z "$group" ] && {
					user_exists $user || user_add $user "$uid" $gid
					group=$ugname
					continue
				}

				group_add_user $ugname $user
			done
		done
	}

	if [ -f ${IPKG_INSTROOT}/usr/lib/opkg/info/${pkgname}.postinst-pkg ]; then
		( . ${IPKG_INSTROOT}/usr/lib/opkg/info/${pkgname}.postinst-pkg )
		ret=$?
	fi
	[ -n "${IPKG_INSTROOT}" ] || rm -f /tmp/luci-indexcache 2>/dev/null

	[ "$PKG_UPGRADE" = "1" ] || for i in `cat ${IPKG_INSTROOT}/usr/lib/opkg/info/${pkgname}.list | grep "^/etc/init.d/"`; do
		[ -n "${IPKG_INSTROOT}" ] && $(which bash) ${IPKG_INSTROOT}/etc/rc.common ${IPKG_INSTROOT}$i enable; \
		[ -n "${IPKG_INSTROOT}" ] || {
			$i enable
			$i start
		}
	done
	return $ret
