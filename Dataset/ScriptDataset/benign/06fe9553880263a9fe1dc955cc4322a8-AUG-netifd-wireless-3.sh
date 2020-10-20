	local error="$1"

	echo "Device setup failed: $error"
	wireless_set_retry 0
