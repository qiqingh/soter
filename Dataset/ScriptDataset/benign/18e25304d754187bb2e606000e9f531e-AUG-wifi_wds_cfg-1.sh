	if [ -n "$1" ]; then
		echo "$1"
	fi
	echo "Usage: $0 -c <channel> -m <peer mac> -n <network mode> -a <security> -p <passphrase>"
	echo "radio: [2g|5g]"
	echo "channel: 1-11 for 2.4Ghz, 36-48 and 149-161 for 5GHz"
	echo "peer mac: [AA:BB:CC:DD:EE:FF]"
	echo "network mode: [a|b|g|n|ac3"
	echo "security: [open|wpa-personal|wpa2-personal] also need passphrase"
	echo "passphrase: passphrase"
	exit
