	check_buffalo_enc "$1" && return 0

	# fall back to allowing unsigned firmware if the region check failed
	! grep -q region.check /proc/modules && \
		[ -f /rom/lib/modules/*/region-check.ko ] && \
		! insmod /rom/lib/modules/*/region-check.ko && \
		return 0

	sig_size=512
	img_size=`wc -c $1 | cut -d" " -f1`
	img_size="$((img_size-$sig_size))"
	tail -c $sig_size $1 > $1.sig
	grep -q "untrusted comment" "$1.sig" || return 1
	head -c $img_size $1 | /usr/bin/signify -V -p /etc/key-build.pub -x "$1.sig" -m -
	R=$?
	[ "$TEST" = 1 -o "$R" != 0 ] || dd bs=1 of="$1" seek="$img_size" count=0 2>/dev/null

	[ "$R" -gt 0 ] && return $R
	for c in $sysupgrade_image_post_check; do
		"$c" "$@"
		R="$?"
		[ "$R" -gt 0 ] && return $R
	done

	return 0
