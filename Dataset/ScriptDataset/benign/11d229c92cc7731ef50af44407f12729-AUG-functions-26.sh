	local grp delim=","
	grp=$(grep -s "^${1}:" ${IPKG_INSTROOT}/etc/group)
	[ -z "$(echo $grp | cut -d: -f4 | grep $2)" ] || return
	[ -n "$(echo $grp | grep ":$")" ] && delim=""
	[ -n "$IPKG_INSTROOT" ] || lock /var/lock/passwd
	sed -i "s/$grp/$grp$delim$2/g" ${IPKG_INSTROOT}/etc/group
	[ -n "$IPKG_INSTROOT" ] || lock -u /var/lock/passwd
