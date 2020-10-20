fwtool_check_signature() {
	[ $# -gt 1 ] && return 1

	[ ! -x /usr/bin/ucert ] && {
		if [ "$REQUIRE_IMAGE_SIGNATURE" = 1 ]; then
			return 1
		else
			return 0
		fi
	}

	if ! fwtool -q -s /tmp/sysupgrade.ucert "$1"; then
		echo "Image signature not found"
		[ "$REQUIRE_IMAGE_SIGNATURE" = 1 -a "$FORCE" != 1 ] && {
			echo "Use sysupgrade -F to override this check when downgrading or flashing to vendor firmware"
		}
		[ "$REQUIRE_IMAGE_SIGNATURE" = 1 ] && return 1
		return 0
	fi

	fwtool -q -T -s /dev/null "$1" | \
		ucert -V -m - -c "/tmp/sysupgrade.ucert" -P /etc/opkg/keys

	return $?
}

