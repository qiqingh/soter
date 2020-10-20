	local name="$1"
	local gid="$2"
	local rc
	[ -f "${IPKG_INSTROOT}/etc/group" ] || return 1
	[ -n "$IPKG_INSTROOT" ] || lock /var/lock/group
	echo "${name}:x:${gid}:" >> ${IPKG_INSTROOT}/etc/group
	rc=$?
	[ -n "$IPKG_INSTROOT" ] || lock -u /var/lock/group
	return $rc
