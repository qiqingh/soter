	echo "${FW} does not exist. Try to Download it ? (y/N)"
	read -n 1 R
	echo ""
	[ "$R" = "y" ] || {
		echo "Please manually download the firmware from ${URL} and copy the file to ${FW}"
		echo "See also https://xdarklight.github.io/lantiq-xdsl-firmware-info/ for alternatives"
		exit 1
	}
	echo "Download w921v Firmware"
	wget "${URL}" -O "${FW}"
	[ $? -eq 0 -a -f "${FW}" ] || exit 1
