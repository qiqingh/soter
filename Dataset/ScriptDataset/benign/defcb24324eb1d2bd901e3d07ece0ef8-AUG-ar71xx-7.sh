	local model
	local magic

	magic="$(ubnt_ac_lite_get_mtd_part_magic)"
	case ${magic:0:4} in
	"e517")
		model="Ubiquiti UniFi-AC-LITE"
		;;
	"e557")
		model="Ubiquiti UniFi-AC-MESH"
		;;
	esac

	[ -z "$model" ] || AR71XX_MODEL="${model}"
