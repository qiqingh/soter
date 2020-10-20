	local model
	local magic

	magic="$(ubnt_get_mtd_part_magic)"
	case ${magic:0:3} in
	"e00"|\
	"e01"|\
	"e80")
		model="Ubiquiti NanoStation M"
		;;
	"e0a")
		model="Ubiquiti NanoStation loco M"
		;;
	"e1b"|\
	"e1d")
		model="Ubiquiti Rocket M"
		;;
	"e20"|\
	"e2d")
		model="Ubiquiti Bullet M"
		;;
	"e30")
		model="Ubiquiti PicoStation M"
		;;
	esac

	[ -z "$model" ] || AR71XX_MODEL="${model}${magic:3:1}"
