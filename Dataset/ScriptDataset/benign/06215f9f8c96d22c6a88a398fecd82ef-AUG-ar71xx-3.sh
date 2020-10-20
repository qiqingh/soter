	local machine="$1"
	local magic
	local name

	name="wndr3700"

	magic="$(ar71xx_get_mtd_part_magic firmware)"
	case $magic in
	"33373030")
		machine="NETGEAR WNDR3700"
		;;
	"33373031")
		model="$(ar71xx_get_mtd_offset_size_format art 41 32 %c)"
		# Use awk to remove everything unprintable
		model_stripped="$(ar71xx_get_mtd_offset_size_format art 41 32 %c | LC_CTYPE=C awk -v 'FS=[^[:print:]]' '{print $1; exit}')"
		case $model in
		$'\xff'*)
			if [ "${model:24:1}" = 'N' ]; then
				machine="NETGEAR WNDRMAC"
			else
				machine="NETGEAR WNDR3700v2"
			fi
			;;
		'29763654+16+64'*)
			machine="NETGEAR ${model_stripped:14}"
			;;
		'29763654+16+128'*)
			machine="NETGEAR ${model_stripped:15}"
			;;
		*)
			# Unknown ID
			machine="NETGEAR ${model_stripped}"
		esac
	esac

	AR71XX_BOARD_NAME="$name"
	AR71XX_MODEL="$machine"
