	local val=$1
	local name
	local version

	case "$val" in
		B5,00,41,4C,43,42*)
			name="Alcatel"
			version=${val##*B5,00,41,4C,43,42,}
			;;
		B5,00,41,4E,44,56*)
			name="Analog Devices"
			version=${val##*B5,00,41,4E,44,56,}
			;;
		B5,00,42,44,43,4D*)
			name="Broadcom"
			version=${val##*B5,00,42,44,43,4D,}
			;;
		B5,00,43,45,4E,54*)
			name="Centillium"
			version=${val##*B5,00,43,45,4E,54,}
			;;
		B5,00,47,53,50,4E*)
			name="Globespan"
			version=${val##*B5,00,47,53,50,4E,}
			;;
		B5,00,49,4B,4E,53*)
			name="Ikanos"
			version=${val##*B5,00,49,4B,4E,53,}
			;;
		B5,00,49,46,54,4E*)
			name="Infineon"
			version=${val##*B5,00,49,46,54,4E,}
			;;
		B5,00,54,53,54,43*)
			name="Texas Instruments"
			version=${val##*B5,00,54,53,54,43,}
			;;
		B5,00,54,4D,4D,42*)
			name="Thomson MultiMedia Broadband"
			version=${val##*B5,00,54,4D,4D,42,}
			;;
		B5,00,54,43,54,4E*)
			name="Trend Chip Technologies"
			version=${val##*B5,00,54,43,54,4E,}
			;;
		B5,00,53,54,4D,49*)
			name="ST Micro"
			version=${val##*B5,00,53,54,4D,49,}
			;;
	esac

	[ -n "$name" ] && {
		val="$name"

		[ "$version" != "00,00" ] && val="$(printf "%s %d.%d" "$val" 0x${version//,/ 0x})"
	}

	echo "$val"
