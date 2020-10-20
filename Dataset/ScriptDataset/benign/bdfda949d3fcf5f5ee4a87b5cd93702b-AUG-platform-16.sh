	local board=$(ar71xx_board_name)
	local magic="$(get_magic_word "$1")"
	local magic_long="$(get_magic_long "$1")"

	[ "$#" -gt 1 ] && return 1

	case "$board" in
	airgatewaypro|\
	airgateway|\
	airrouter|\
	ap132|\
	ap90q|\
	bullet-m|\
	c-55|\
	carambola2|\
	cf-e316n-v2|\
	cf-e320n-v2|\
	cf-e380ac-v1|\
	cf-e380ac-v2|\
	cf-e520n|\
	cf-e530n|\
	cpe830|\
	cpe870|\
	dgl-5500-a1|\
	dhp-1565-a1|\
	dir-505-a1|\
	dir-600-a1|\
	dir-615-c1|\
	dir-615-e1|\
	dir-615-e4|\
	dir-615-i1|\
	dir-825-c1|\
	dir-835-a1|\
	dlan-hotspot|\
	dlan-pro-1200-ac|\
	dlan-pro-500-wp|\
	dr531|\
	dragino2|\
	epg5000|\
	esr1750|\
	esr900|\
	ew-dorin-router|\
	ew-dorin|\
	gl-ar150|\
	gl-ar300m|\
	gl-ar300|\
	gl-domino|\
	gl-mifi|\
	hiwifi-hc6361|\
	hornet-ub-x2|\
	jwap230|\
	loco-m-xw|\
	mzk-w04nu|\
	mzk-w300nh|\
	nanostation-m-xw|\
	nanostation-m|\
	nbg460n_550n_550nh|\
	rocket-m-ti|\
	rocket-m-xw|\
	rocket-m|\
	rw2458n|\
	sr3200|\
	tew-632brp|\
	tew-712br|\
	tew-732br|\
	tew-823dru|\
	unifi-outdoor|\
	unifiac-lite|\
	unifiac-pro|\
	unifi|\
	weio|\
	whr-g301n|\
	whr-hp-g300n|\
	whr-hp-gn|\
	wlae-ag300n|\
	wndap360|\
	wpj342|\
	wpj344|\
	wpj531|\
	wrt400n|\
	wrtnode2q|\
	wzr-450hp2|\
	wzr-hp-ag300h|\
	wzr-hp-g300nh2|\
	wzr-hp-g300nh|\
	wzr-hp-g450h|\
	xd3200)
		[ "$magic" != "2705" ] && {
			echo "Invalid image type."
			return 1
		}

		return 0
		;;
	alfa-ap96|\
	alfa-nx|\
	ap121-mini|\
	ap121|\
	ap135-020|\
	ap136-010|\
	ap136-020|\
	ap147-010|\
	ap152|\
	ap96|\
	arduino-yun|\
	bhr-4grv2|\
	bxu2000n-2-a1|\
	db120|\
	dr344|\
	dw33d|\
	f9k1115v2|\
	hornet-ub|\
	mr12|\
	mr16|\
	wpj558|\
	zbt-we1526|\
	zcn-1523h-2|\
	zcn-1523h-5)
		[ "$magic_long" != "68737173" -a "$magic_long" != "19852003" ] && {
			echo "Invalid image type."
			return 1
		}

		return 0
		;;
	all0258n|\
	all0315n|\
	cap324|\
	cap4200ag|\
	cr3000|\
	cr5000)
		platform_check_image_allnet "$1" && return 0
		return 1
		;;
	all0305|\
	eap300v2|\
	eap7660d|\
	ja76pf2|\
	ja76pf|\
	jwap003|\
	ls-sr71|\
	pb42|\
	pb44|\
	rb-941-2nd|\
	routerstation-pro|\
	routerstation|\
	wp543|\
	wpe72)
		[ "$magic" != "4349" ] && {
			echo "Invalid image. Use *-sysupgrade.bin files on this board"
			return 1
		}

		local md5_img=$(dd if="$1" bs=2 skip=9 count=16 2>/dev/null)
		local md5_chk=$(dd if="$1" bs=$CI_BLKSZ skip=1 2>/dev/null | md5sum -); md5_chk="${md5_chk%% *}"

		if [ -n "$md5_img" -a -n "$md5_chk" ] && [ "$md5_img" = "$md5_chk" ]; then
			return 0
		else
			echo "Invalid image. Contents do not match checksum (image:$md5_img calculated:$md5_chk)"
			return 1
		fi

		return 0
		;;
	antminer-s1|\
	antminer-s3|\
	antrouter-r1|\
	archer-c5|\
	archer-c7|\
	el-m150|\
	el-mini|\
	gl-inet|\
	mc-mac1200r|\
	minibox-v1|\
	omy-g1|\
	omy-x1|\
	onion-omega|\
	oolite|\
	re450|\
	smart-300|\
	som9331|\
	tellstick-znet-lite|\
	tl-mr10u|\
	tl-mr11u|\
	tl-mr12u|\
	tl-mr13u|\
	tl-mr3020|\
	tl-mr3040-v2|\
	tl-mr3040|\
	tl-mr3220-v2|\
	tl-mr3220|\
	tl-mr3420-v2|\
	tl-mr3420|\
	tl-wa701nd-v2|\
	tl-wa7210n-v2|\
	tl-wa750re|\
	tl-wa7510n|\
	tl-wa801nd-v2|\
	tl-wa801nd-v3|\
	tl-wa830re-v2|\
	tl-wa850re|\
	tl-wa860re|\
	tl-wa901nd-v2|\
	tl-wa901nd-v3|\
	tl-wa901nd-v4|\
	tl-wa901nd|\
	tl-wdr3320-v2|\
	tl-wdr3500|\
	tl-wdr4300|\
	tl-wdr4900-v2|\
	tl-wdr6500-v2|\
	tl-wpa8630|\
	tl-wr1041n-v2|\
	tl-wr1043nd-v2|\
	tl-wr1043nd-v4|\
	tl-wr1043nd|\
	tl-wr2543n|\
	tl-wr703n|\
	tl-wr710n|\
	tl-wr720n-v3|\
	tl-wr741nd-v4|\
	tl-wr741nd|\
	tl-wr802n-v1|\
	tl-wr810n|\
	tl-wr841n-v11|\
	tl-wr841n-v1|\
	tl-wr841n-v7|\
	tl-wr841n-v8|\
	tl-wr841n-v9|\
	tl-wr842n-v2|\
	tl-wr842n-v3|\
	tl-wr941nd-v5|\
	tl-wr941nd-v6|\
	tl-wr940n-v4|\
	tl-wr941nd)
		local magic_ver="0100"

		case "$board" in
		tl-wdr6500-v2)
			magic_ver="0200"
			;;
		esac

		[ "$magic" != "$magic_ver" ] && {
			echo "Invalid image type."
			return 1
		}

		local hwid
		local mid
		local imagehwid
		local imagemid

		hwid=$(tplink_get_hwid)
		mid=$(tplink_get_mid)
		imagehwid=$(tplink_get_image_hwid "$1")
		imagemid=$(tplink_get_image_mid "$1")

		[ "$hwid" != "$imagehwid" -o "$mid" != "$imagemid" ] && {
			echo "Invalid image, hardware ID mismatch, hw:$hwid $mid image:$imagehwid $imagemid."
			return 1
		}

		local boot_size

		boot_size=$(tplink_get_image_boot_size "$1")
		[ "$boot_size" != "00000000" ] && {
			echo "Invalid image, it contains a bootloader."
			return 1
		}

		return 0
		;;
	bsb|\
	dir-825-b1|\
	tew-673gru)
		dir825b_check_image "$1" && return 0
		;;
	rb*)
		nand_do_platform_check routerboard $1
		return $?
		;;
	c-60|\
	nbg6716|\
	r6100|\
	wndr3700v4|\
	wndr4300)
		nand_do_platform_check $board $1
		return $?
		;;
	cpe210|\
	cpe510|\
	eap120|\
	wbs210|\
	wbs510)
		tplink_pharos_check_image "$1" && return 0
		return 1
		;;
	a40|\
	a60|\
	mr1750v2|\
	mr1750|\
	mr600v2|\
	mr600|\
	mr900v2|\
	mr900|\
	om2p-hsv2|\
	om2p-hsv3|\
	om2p-hsv4|\
	om2p-hs|\
	om2p-lc|\
	om2pv2|\
	om2pv4|\
	om2p|\
	om5p-acv2|\
	om5p-ac|\
	om5p-an|\
	om5p)
		platform_check_image_openmesh "$magic_long" "$1" && return 0
		return 1
		;;
	mr18|\
	z1)
		merakinand_do_platform_check $board $1
		return $?
		;;
	dir-869-a1|\
	mynet-n600|\
	mynet-n750|\
	qihoo-c301)
		[ "$magic_long" != "5ea3a417" ] && {
			echo "Invalid image, bad magic: $magic_long"
			return 1
		}

		local typemagic=$(seama_get_type_magic "$1")
		[ "$typemagic" != "6669726d" ] && {
			echo "Invalid image, bad type: $typemagic"
			return 1
		}

		return 0
		;;
	e2100l|\
	mynet-rext|\
	wrt160nl)
		cybertan_check_image "$1" && return 0
		return 1
		;;
	nbg6616|\
	uap-pro|\
	unifi-outdoor-plus)
		[ "$magic_long" != "19852003" ] && {
			echo "Invalid image type."
			return 1
		}

		return 0
		;;
	tube2h)
		alfa_check_image "$1" && return 0
		return 1
		;;
	wndr3700|\
	wnr1000-v2|\
	wnr2000-v3|\
	wnr612-v2|\
	wpn824n)
		local hw_magic

		hw_magic="$(ar71xx_get_mtd_part_magic firmware)"
		[ "$magic_long" != "$hw_magic" ] && {
			echo "Invalid image, hardware ID mismatch, hw:$hw_magic image:$magic_long."
			return 1
		}

		return 0
		;;
	wnr2000-v4)
		[ "$magic_long" != "32303034" ] && {
			echo "Invalid image type."
			return 1
		}

		return 0
		;;
	wnr2200)
		[ "$magic_long" != "32323030" ] && {
			echo "Invalid image type."
			return 1
		}

		return 0
		;;
	dap-2695-a1)
		local magic=$(wrgg_get_image_magic "$1")
		[ "$magic" != "21030820" ] && {
			echo "Invalid image, bad type: $magic"
			return 1
		}

		return 0;
		;;
	esac

	echo "Sysupgrade is not yet supported on $board."
	return 1
