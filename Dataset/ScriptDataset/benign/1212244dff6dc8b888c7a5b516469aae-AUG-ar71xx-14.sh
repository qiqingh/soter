	local machine
	local name

	machine=$(awk 'BEGIN{FS="[ \t]+:[ \t]"} /machine/ {print $2}' /proc/cpuinfo)

	case "$machine" in
	*"Oolite V1.0")
		name="oolite"
		;;
	*"AC1750DB")
		name="f9k1115v2"
		;;
	*"AirGateway")
		name="airgateway"
		;;
	*"AirGateway Pro")
		name="airgatewaypro"
		;;
	*"AirRouter")
		name="airrouter"
		;;
	*"ALFA Network AP120C")
		name="alfa-ap120c"
		;;
	*"ALFA Network AP96")
		name="alfa-ap96"
		;;
	*"ALFA Network N2/N5")
		name="alfa-nx"
		;;
	*ALL0258N)
		name="all0258n"
		;;
	*ALL0305)
		name="all0305"
		;;
	*ALL0315N)
		name="all0315n"
		;;
	*Antminer-S1)
		name="antminer-s1"
		;;
	*Antminer-S3)
		name="antminer-s3"
		;;
	*"Arduino Yun")
		name="arduino-yun"
		;;
	*"AP121 reference board")
		name="ap121"
		;;
	*AP121-MINI)
		name="ap121-mini"
		;;
	*"AP132 reference board")
		name="ap132"
		;;
	*"AP136-010 reference board")
		name="ap136-010"
		;;
	*"AP136-020 reference board")
		name="ap136-020"
		;;
	*"AP135-020 reference board")
		name="ap135-020"
		;;
	*"AP143 reference board")
		name="ap143"
		;;
	*"AP147-010 reference board")
		name="ap147-010"
		;;
	*"AP152 reference board")
		name="ap152"
		;;
	*AP90Q)
		name="ap90q"
		;;
	*"Archer C5")
		name="archer-c5"
		;;
	*"Archer C7")
		name="archer-c7"
		;;
	*"Atheros AP96")
		name="ap96"
		;;
	*AW-NR580)
		name="aw-nr580"
		;;
	*BHR-4GRV2)
		name="bhr-4grv2"
		;;
	*CAP324)
		name="cap324"
		;;
	*C-55)
		name="c-55"
		;;
	*C-60)
		name="c-60"
		;;
	*CAP4200AG)
		name="cap4200ag"
		;;
	*"CF-E316N v2")
		name="cf-e316n-v2"
		;;
	*"CF-E320N v2")
		name="cf-e320n-v2"
		;;
	*"CF-E380AC v1")
		name="cf-e380ac-v1"
		;;
	*"CF-E380AC v2")
		name="cf-e380ac-v2"
		;;
	*CF-E520N)
		name="cf-e520n"
		;;
	*CF-E530N)
		name="cf-e530n"
		;;
	*"CPE210/220")
		name="cpe210"
		tplink_pharos_board_detect
		;;
	*"CPE510/520")
		name="cpe510"
		tplink_pharos_board_detect
		;;
	*CPE830)
		name="cpe830"
		;;
	*CPE870)
		name="cpe870"
		;;
	*WBS210)
		name="wbs210"
		tplink_pharos_board_detect
		;;
	*WBS510)
		name="wbs510"
		tplink_pharos_board_detect
		;;
	*CR3000)
		name="cr3000"
		;;
	*CR5000)
		name="cr5000"
		;;
	*"DAP-2695 rev. A1")
		name="dap-2695-a1"
		;;
	*"DB120 reference board")
		name="db120"
		;;
	*"DGL-5500 rev. A1")
		name="dgl-5500-a1"
		;;
	*"DHP-1565 rev. A1")
		name="dhp-1565-a1"
		;;
	*"DIR-505 rev. A1")
		name="dir-505-a1"
		dir505_board_detect
		;;
	*"DIR-600 rev. A1")
		name="dir-600-a1"
		;;
	*"DIR-615 rev. E1")
		name="dir-615-e1"
		;;
	*"DIR-615 rev. E4")
		name="dir-615-e4"
		;;
	*"DIR-615 rev. I1")
		name="dir-615-i1"
		;;
	*"DIR-825 rev. B1")
		name="dir-825-b1"
		;;
	*"DIR-825 rev. C1")
		name="dir-825-c1"
		;;
	*"DIR-835 rev. A1")
		name="dir-835-a1"
		;;
	*"DIR-869 rev. A1")
		name="dir-869-a1"
		;;
	*"dLAN Hotspot")
		name="dlan-hotspot"
		;;
	*"dLAN pro 500 Wireless+")
		name="dlan-pro-500-wp"
		;;
	*"dLAN pro 1200+ WiFi ac")
		name="dlan-pro-1200-ac"
		;;
	*DR344)
		name="dr344"
		;;
	*DR531)
		name="dr531"
		;;
	*"Dragino v2")
		name="dragino2"
		;;
	*"Domino Pi")
		name="gl-domino"
		;;
	*"DW33D")
		name="dw33d"
		;;
	*E2100L)
		name="e2100l"
		;;
	*"EAP120")
		name="eap120"
		tplink_pharos_board_detect
		;;
	*"EAP300 v2")
		name="eap300v2"
		;;
	*EAP7660D)
		name="eap7660d"
		;;
	*EL-M150)
		name="el-m150"
		;;
	*EL-MINI)
		name="el-mini"
		;;
	*"GL-CONNECT INET v1")
		name="gl-inet"
		gl_inet_board_detect
		;;
	*"GL AR150")
		name="gl-ar150"
		;;
	*"GL AR300")
		name="gl-ar300"
		;;
	*"GL-AR300M")
		name="gl-ar300m"
		;;
	*"GL-MIFI")
		name="gl-mifi"
		;;
	*"EnGenius EPG5000")
		name="epg5000"
		;;
	*"EnGenius ESR1750")
		name="esr1750"
		;;
	*"EnGenius ESR900")
		name="esr900"
		;;
	*JA76PF)
		name="ja76pf"
		;;
	*JA76PF2)
		name="ja76pf2"
		;;
	*"Bullet M")
		name="bullet-m"
		ubnt_xm_board_detect
		;;
	*"Loco M XW")
		name="loco-m-xw"
		;;
	*"Nanostation M")
		name="nanostation-m"
		ubnt_xm_board_detect
		;;
	*"Nanostation M XW")
		name="nanostation-m-xw"
		;;
	*JWAP003)
		name="jwap003"
		;;
	*JWAP230)
		name="jwap230"
		;;
	*"Hornet-UB")
		local size
		size=$(awk '/firmware/ { print $2 }' /proc/mtd)

		if [ "x$size" = "x00790000" ]; then
			name="hornet-ub"
		fi

		if [ "x$size" = "x00f90000" ]; then
			name="hornet-ub-x2"
		fi
		;;
	*LS-SR71)
		name="ls-sr71"
		;;
	*"MAC1200R")
		name="mc-mac1200r"
		;;
	*"MiniBox V1.0")
		name="minibox-v1"
		;;
	*MR12)
		name="mr12"
		;;
	*MR16)
		name="mr16"
		;;
	*MR18)
		name="mr18"
		;;
	*MR600v2)
		name="mr600v2"
		;;
	*MR1750)
		name="mr1750"
		;;
	*MR1750v2)
		name="mr1750v2"
		;;
	*MR600)
		name="mr600"
		;;
	*MR900)
		name="mr900"
		;;
	*MR900v2)
		name="mr900v2"
		;;
	*"My Net N600")
		name="mynet-n600"
		;;
	*"My Net N750")
		name="mynet-n750"
		;;
	*"WD My Net Wi-Fi Range Extender")
		name="mynet-rext"
		;;
	*MZK-W04NU)
		name="mzk-w04nu"
		;;
	*MZK-W300NH)
		name="mzk-w300nh"
		;;
	*"NBG460N/550N/550NH")
		name="nbg460n_550n_550nh"
		;;
	*"Zyxel NBG6616")
		name="nbg6616"
		;;
	*"Zyxel NBG6716")
		name="nbg6716"
		;;
	*OM2P)
		name="om2p"
		;;
	*OM2Pv2)
		name="om2pv2"
		;;
	*"OM2P HS")
		name="om2p-hs"
		;;
	*"OM2P HSv2")
		name="om2p-hsv2"
		;;
	*"OM2P HSv3")
		name="om2p-hsv3"
		;;
	*"OM2P LC")
		name="om2p-lc"
		;;
	*OM5P)
		name="om5p"
		;;
	*"OM5P AN")
		name="om5p-an"
		;;
	*"OM5P AC")
		name="om5p-ac"
		;;
	*"OM5P ACv2")
		name="om5p-acv2"
		;;
	*"OMY-X1")
		name="omy-x1"
		;;
	*"OMY-G1")
		name="omy-g1"
		;;
	*"Onion Omega")
		name="onion-omega"
		;;
	*PB42)
		name="pb42"
		;;
	*"PB44 reference board")
		name="pb44"
		;;
	*"Qihoo 360 C301")
		name="qihoo-c301"
		;;
	*"RE450")
		name="re450"
		;;
	*"RouterBOARD 411/A/AH")
		name="rb-411"
		;;
	*"RouterBOARD 411U")
		name="rb-411u"
		;;
	*"RouterBOARD 433/AH")
		name="rb-433"
		;;
	*"RouterBOARD 433UAH")
		name="rb-433u"
		;;
	*"RouterBOARD 435G")
		name="rb-435g"
		;;
	*"RouterBOARD 450")
		name="rb-450"
		;;
	*"RouterBOARD 450G")
		name="rb-450g"
		;;
	*"RouterBOARD 493/AH")
		name="rb-493"
		;;
	*"RouterBOARD 493G")
		name="rb-493g"
		;;
	*"RouterBOARD 750")
		name="rb-750"
		;;
	*"RouterBOARD 750GL")
		name="rb-750gl"
		;;
	*"RouterBOARD 751")
		name="rb-751"
		;;
	*"RouterBOARD 751G")
		name="rb-751g"
		;;
	*"RouterBOARD 911G-2HPnD")
		name="rb-911g-2hpnd"
		;;
	*"RouterBOARD 911G-5HPnD")
		name="rb-911g-5hpnd"
		;;
	*"RouterBOARD 911G-5HPacD")
		name="rb-911g-5hpacd"
		;;
	*"RouterBOARD 912UAG-2HPnD")
		name="rb-912uag-2hpnd"
		;;
	*"RouterBOARD 912UAG-5HPnD")
		name="rb-912uag-5hpnd"
		;;
	*"RouterBOARD 941-2nD")
		name="rb-941-2nd"
		;;
	*"RouterBOARD 951G-2HnD")
		name="rb-951g-2hnd"
		;;
	*"RouterBOARD 951Ui-2HnD")
		name="rb-951ui-2hnd"
		;;
	*"RouterBOARD 2011L")
		name="rb-2011l"
		;;
	*"RouterBOARD 2011UAS")
		name="rb-2011uas"
		;;
	*"RouterBOARD 2011UiAS")
		name="rb-2011uias"
		;;
	*"RouterBOARD 2011UAS-2HnD")
		name="rb-2011uas-2hnd"
		;;
	*"RouterBOARD 2011UiAS-2HnD")
		name="rb-2011uias-2hnd"
		;;
	*"RouterBOARD SXT Lite2")
		name="rb-sxt2n"
		;;
	*"RouterBOARD SXT Lite5")
		name="rb-sxt5n"
		;;
	*"Rocket M")
		name="rocket-m"
		ubnt_xm_board_detect
		;;
	*"Rocket M TI")
		name="rocket-m-ti"
		;;
	*"Rocket M XW")
		name="rocket-m-xw"
		;;
	*RouterStation)
		name="routerstation"
		;;
	*"RouterStation Pro")
		name="routerstation-pro"
		;;
	*RW2458N)
		name="rw2458n"
		;;
	*"SMART-300")
		name="smart-300"
		;;
	"Smart Electronics Black Swift board"*)
		name="bsb"
		;;
	*"Telldus TellStick ZNet Lite")
		name="tellstick-znet-lite"
		;;
	*SOM9331)
		name="som9331"
		;;
	*SR3200)
		name="sr3200"
		;;
	*TEW-632BRP)
		name="tew-632brp"
		;;
	*TEW-673GRU)
		name="tew-673gru"
		;;
	*TEW-712BR)
		name="tew-712br"
		;;
	*TEW-732BR)
		name="tew-732br"
		;;
	*TEW-823DRU)
		name="tew-823dru"
		;;
	*"TL-WR1041N v2")
		name="tl-wr1041n-v2"
		;;
	*TL-WR1043ND)
		name="tl-wr1043nd"
		;;
	*"TL-WR1043ND v2")
		name="tl-wr1043nd-v2"
		;;
	*"TL-WR1043ND v4")
		name="tl-wr1043nd-v4"
		;;
	*TL-WR2543N*)
		name="tl-wr2543n"
		;;
	*"DIR-615 rev. C1")
		name="dir-615-c1"
		;;
	*TL-MR3020)
		name="tl-mr3020"
		;;
	*TL-MR3040)
		name="tl-mr3040"
		;;
	*"TL-MR3040 v2")
		name="tl-mr3040-v2"
		;;
	*TL-MR3220)
		name="tl-mr3220"
		;;
	*"TL-MR3220 v2")
		name="tl-mr3220-v2"
		;;
	*TL-MR3420)
		name="tl-mr3420"
		;;
	*"TL-MR3420 v2")
		name="tl-mr3420-v2"
		;;
	*"TL-WA701ND v2")
		name="tl-wa701nd-v2"
		;;
	*"TL-WA7210N v2")
		name="tl-wa7210n-v2"
		;;
	*TL-WA750RE)
		name="tl-wa750re"
		;;
	*"TL-WA7510N v1")
		name="tl-wa7510n"
		;;
	*TL-WA850RE)
		name="tl-wa850re"
		;;
	*TL-WA860RE)
		name="tl-wa860re"
		;;
	*"TL-WA830RE v2")
		name="tl-wa830re-v2"
		;;
	*"TL-WA801ND v2")
		name="tl-wa801nd-v2"
		;;
	*"TL-WA801ND v3")
		name="tl-wa801nd-v3"
		;;
	*"TL-WR802N v1")
		name="tl-wr802n-v1"
		;;
	*TL-WA901ND)
		name="tl-wa901nd"
		;;
	*"TL-WA901ND v2")
		name="tl-wa901nd-v2"
		;;
	*"TL-WA901ND v3")
		name="tl-wa901nd-v3"
		;;
	*"TL-WA901ND v4")
		name="tl-wa901nd-v4"
		;;
	*"TL-WDR3320 v2")
		name="tl-wdr3320-v2"
		;;
	*"TL-WDR3500")
		name="tl-wdr3500"
		;;
	*"TL-WDR3600/4300/4310")
		name="tl-wdr4300"
		;;
	*"TL-WDR4900 v2")
		name="tl-wdr4900-v2"
		;;
	*"TL-WDR6500 v2")
		name="tl-wdr6500-v2"
		;;
	*TL-WPA8630)
		name="tl-wpa8630"
		;;
	*TL-WR741ND)
		name="tl-wr741nd"
		;;
	*"TL-WR741ND v4")
		name="tl-wr741nd-v4"
		;;
	*"TL-WR841N v1")
		name="tl-wr841n-v1"
		;;
	*"TL-WR841N/ND v7")
		name="tl-wr841n-v7"
		;;
	*"TL-WR841N/ND v8")
		name="tl-wr841n-v8"
		;;
	*"TL-WR841N/ND v9")
		name="tl-wr841n-v9"
		;;
	*"TL-WR841N/ND v11")
		name="tl-wr841n-v11"
		;;
	*"TL-WR842N/ND v2")
		name="tl-wr842n-v2"
		;;
	*"TL-WR842N/ND v3")
		name="tl-wr842n-v3"
		;;
	*TL-WR941ND)
		name="tl-wr941nd"
		;;
	*"TL-WR941N/ND v5")
		name="tl-wr941nd-v5"
		;;
	*"TL-WR941N/ND v6")
		name="tl-wr941nd-v6"
		;;
	*"TL-WR940N v4")
		name="tl-wr940n-v4"
		;;
	*"TL-WR703N v1")
		name="tl-wr703n"
		;;
	*"TL-WR710N v1")
		name="tl-wr710n"
		;;
	*"TL-WR720N"*)
		name="tl-wr720n-v3"
		;;
	*"TL-WR810N")
		name="tl-wr810n"
		;;
	*"TL-MR10U")
		name="tl-mr10u"
		;;
	*"TL-MR11U")
		name="tl-mr11u"
		;;
	*"TL-MR12U")
		name="tl-mr12u"
		;;
	*"TL-MR13U v1")
		name="tl-mr13u"
		;;
	*"Tube2H")
		name="tube2h"
		;;
	*UniFi)
		name="unifi"
		;;
	*"UniFi-AC-LITE")
		name="unifiac-lite"
		;;
	*"UniFi-AC-PRO")
		name="unifiac-pro"
		;;
	*"UniFi AP Pro")
		name="uap-pro"
		;;
	"WeIO"*)
		name="weio"
		;;
	*WHR-G301N)
		name="whr-g301n"
		;;
	*WHR-HP-GN)
		name="whr-hp-gn"
		;;
	*WLAE-AG300N)
		name="wlae-ag300n"
		;;
	*"UniFiAP Outdoor")
		name="unifi-outdoor"
		;;
	*"UniFiAP Outdoor+")
		name="unifi-outdoor-plus"
		;;
	*WP543)
		name="wp543"
		;;
	*WPE72)
		name="wpe72"
		;;
	*WPJ342)
		name="wpj342"
		;;
	*WPJ344)
		name="wpj344"
		;;
	*WPJ531)
		name="wpj531"
		;;
	*WPJ558)
		name="wpj558"
		;;
	*WNDAP360)
		name="wndap360"
		;;
	*"WNDR3700/WNDR3800/WNDRMAC")
		wndr3700_board_detect "$machine"
		;;
	*"R6100")
		name="r6100"
		;;
	*"WNDR3700v4")
		name="wndr3700v4"
		;;
	*"WNDR4300")
		name="wndr4300"
		;;
	*"WNR2000 V4")
		name="wnr2000-v4"
		;;
	*"WNR2000 V3")
		name="wnr2000-v3"
		;;
	*WNR2000)
		name="wnr2000"
		;;
	*WNR2200)
		name="wnr2200"
		;;
	*"WNR612 V2")
		name="wnr612-v2"
		;;
	*"WNR1000 V2")
		name="wnr1000-v2"
		;;
	*WPN824N)
		name="wpn824n"
		;;
	*WRT160NL)
		name="wrt160nl"
		;;
	*WRT400N)
		name="wrt400n"
		;;
	*"WRTnode2Q board")
		name="wrtnode2q"
		;;
	*"WZR-450HP2")
		name="wzr-450hp2"
		;;
	*"WZR-HP-AG300H/WZR-600DHP")
		name="wzr-hp-ag300h"
		;;
	*WZR-HP-G300NH)
		name="wzr-hp-g300nh"
		;;
	*WZR-HP-G450H)
		name="wzr-hp-g450h"
		;;
	*WZR-HP-G300NH2)
		name="wzr-hp-g300nh2"
		;;
	*WHR-HP-G300N)
		name="whr-hp-g300n"
		;;
	*XD3200)
		name="xd3200"
		;;
	*Z1)
		name="z1"
		;;
	*ZBT-WE1526)
		name="zbt-we1526"
		;;
	*ZCN-1523H-2)
		name="zcn-1523h-2"
		;;
	*ZCN-1523H-5)
		name="zcn-1523h-5"
		;;
	*EmbWir-Dorin)
		name="ew-dorin"
		;;
	*EmbWir-Dorin-Router)
		name="ew-dorin-router"
		;;
	"8devices Carambola2"*)
		name="carambola2"
		;;
	*"Sitecom WLR-8100")
		name="wlr8100"
		;;
	*"BHU BXU2000n-2 rev. A1")
		name="bxu2000n-2-a1"
		;;
	*"HiWiFi HC6361")
		name="hiwifi-hc6361"
		;;
	esac

	[ -z "$AR71XX_MODEL" ] && [ "${machine:0:8}" = 'TP-LINK ' ] && \
		tplink_board_detect "$machine"

	[ -z "$name" ] && name="unknown"

	[ -z "$AR71XX_BOARD_NAME" ] && AR71XX_BOARD_NAME="$name"
	[ -z "$AR71XX_MODEL" ] && AR71XX_MODEL="$machine"

	[ -e "/tmp/sysinfo/" ] || mkdir -p "/tmp/sysinfo/"

	echo "$AR71XX_BOARD_NAME" > /tmp/sysinfo/board_name
	echo "$AR71XX_MODEL" > /tmp/sysinfo/model
