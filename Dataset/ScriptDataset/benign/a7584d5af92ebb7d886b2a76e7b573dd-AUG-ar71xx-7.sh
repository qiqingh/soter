	local model
	local magic

	magic="$(ubnt_unifi_ac_get_mtd_part_magic)"
	case ${magic:0:4} in
	"e517")
		model="Ubiquiti UniFi-AC-LITE"
		;;
	"e537")
		model="Ubiquiti UniFi-AC-PRO"
		;;
	"e557")
		model="Ubiquiti UniFi-AC-MESH"
		;;
	"e567")
		model="Ubiquiti UniFi-AC-MESH-PRO"
		;;
	esac

	[ -z "$model" ] || AR71XX_MODEL="${model}"
