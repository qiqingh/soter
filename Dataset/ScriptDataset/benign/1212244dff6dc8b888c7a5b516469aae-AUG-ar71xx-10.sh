	local model="$1"
	local hwid
	local hwver

	hwid=$(tplink_get_hwid)
	mid=$(tplink_get_mid)
	hwver=${hwid:6:2}
	hwver=" v${hwver#0}"

	case "$hwid" in
	"015000"*)
		model="EasyLink EL-M150"
		;;
	"015300"*)
		model="EasyLink EL-MINI"
		;;
	"044401"*)
		model="ANTMINER-S1"
		;;
	"044403"*)
		model="ANTMINER-S3"
		;;
	"44440101"*)
		model="ANTROUTER-R1"
		;;
	"120000"*)
		model="MERCURY MAC1200R"
		;;
	"007260"*)
		model="TellStick ZNet Lite"
		;;
	"066601"*)
		model="OMYlink OMY-G1"
		;;
	"066602"*)
		model="OMYlink OMY-X1"
		;;
	"3C0001"*)
		model="OOLITE"
		;;
	"3C0002"*)
		model="MINIBOX_V1"
		;;
	"070301"*)
		model="TP-Link TL-WR703N"
		;;
	"071000"*)
		model="TP-Link TL-WR710N"

		if [ "$hwid" = '07100002' -a "$mid" = '00000002' ]; then
			hwver=' v2.1'
		fi
		;;
	"072001"*)
		model="TP-Link TL-WR720N"
		;;
	"070100"*)
		model="TP-Link TL-WA701N/ND"
		;;
	"073000"*)
		model="TP-Link TL-WA730RE"
		;;
	"074000"*)
		model="TP-Link TL-WR740N/ND"
		;;
	"074100"*)
		model="TP-Link TL-WR741N/ND"
		;;
	"074300"*)
		model="TP-Link TL-WR743N/ND"
		;;
	"075000"*)
		model="TP-Link TL-WA750RE"
		;;
	"721000"*)
		model="TP-Link TL-WA7210N"
		;;
	"751000"*)
		model="TP-Link TL-WA7510N"
		;;
	"080100"*)
		model="TP-Link TL-WA801N/ND"
		;;
	"080200"*)
		model="TP-Link TL-WR802N"
		;;
	"083000"*)
		model="TP-Link TL-WA830RE"

		if [ "$hwver" = ' v10' ]; then
			hwver=' v1'
		fi
		;;
	"084100"*)
		model="TP-Link TL-WR841N/ND"

		if [ "$hwid" = '08410002' -a "$mid" = '00000002' ]; then
			hwver=' v1.5'
		fi
		;;
	"084200"*)
		model="TP-Link TL-WR842N/ND"
		;;
	"084300"*)
		model="TP-Link TL-WR843N/ND"
		;;
	"085000"*)
		model="TP-Link TL-WA850RE"
		;;
	"086000"*)
		model="TP-Link TL-WA860RE"
		;;
	"090100"*)
		model="TP-Link TL-WA901N/ND"
		;;
	"094000"*)
		model="TP-Link TL-WR940N"
		;;
	"094100"*)
		if [ "$hwid" = "09410002" -a "$mid" = "00420001" ]; then
			model="Rosewill RNX-N360RT"
			hwver=""
		else
			model="TP-Link TL-WR941N/ND"
		fi
		;;
	"104100"*)
		model="TP-Link TL-WR1041N/ND"
		;;
	"104300"*)
		model="TP-Link TL-WR1043N/ND"
		;;
	"254300"*)
		model="TP-Link TL-WR2543N/ND"
		;;
	"001001"*)
		model="TP-Link TL-MR10U"
		;;
	"001101"*)
		model="TP-Link TL-MR11U"
		;;
	"001201"*)
		model="TP-Link TL-MR12U"
		;;
	"001301"*)
		model="TP-Link TL-MR13U"
		;;
	"302000"*)
		model="TP-Link TL-MR3020"
		;;
	"304000"*)
		model="TP-Link TL-MR3040"
		;;
	"322000"*)
		model="TP-Link TL-MR3220"
		;;
	"342000"*)
		model="TP-Link TL-MR3420"
		;;
	"332000"*)
		model="TP-Link TL-WDR3320"
		;;
	"350000"*)
		model="TP-Link TL-WDR3500"
		;;
	"360000"*)
		model="TP-Link TL-WDR3600"
		;;
	"430000"*)
		model="TP-Link TL-WDR4300"
		;;
	"430080"*)
		iw reg set IL
		model="TP-Link TL-WDR4300 (IL)"
		;;
	"431000"*)
		model="TP-Link TL-WDR4310"
		;;
	"49000002")
		model="TP-Link TL-WDR4900"
		;;
	"65000002")
		model="TP-Link TL-WDR6500"
		;;
	"453000"*)
		model="Mercury MW4530R"
		;;
	"934100"*)
		model="NC-LINK SMART-300"
		;;
	"c50000"*)
		model="TP-Link Archer C5"
		;;
	"750000"*|\
	"c70000"*)
		model="TP-Link Archer C7"
		;;
	*)
		hwver=""
		;;
	esac

	AR71XX_MODEL="$model$hwver"
