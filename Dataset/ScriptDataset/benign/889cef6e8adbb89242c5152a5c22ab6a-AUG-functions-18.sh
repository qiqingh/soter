	local pkgname="$1"
	local rusers="$(sed -ne 's/^Require-User: *//p' $root/usr/lib/opkg/info/${pkgname}.control 2>/dev/null)"

	if [ -n "$rusers" ]; then
		local tuple oIFS="$IFS"
		for tuple in $rusers; do
			local uid gid uname gname

			IFS=":"
			set -- $tuple; uname="$1"; gname="$2"
			IFS="="
			set -- $uname; uname="$1"; uid="$2"
			set -- $gname; gname="$1"; gid="$2"
			IFS="$oIFS"

			if [ -n "$gname" ] && [ -n "$gid" ]; then
				group_exists "$gname" || group_add "$gname" "$gid"
			elif [ -n "$gname" ]; then
				group_add_next "$gname"; gid=$?
			fi

			if [ -n "$uname" ]; then
				user_exists "$uname" || user_add "$uname" "$uid" "$gid"
			fi

			if [ -n "$uname" ] && [ -n "$gname" ]; then
				group_add_user "$gname" "$uname"
			fi

			unset uid gid uname gname
		done
	fi
