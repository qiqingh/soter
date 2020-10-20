	[ -z "$1" ] && exit 0
	if [ $(hexdump -n 4 -e '4 "%c"' $1) != "$(nvram_get 2860 code_pt)" ]; then
		echo "code pattern is wrong!" > /dev/console
		return 1
        fi

	return 0	
