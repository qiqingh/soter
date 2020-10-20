	case "$(board_name)" in
	actiontec,r1000h)
		status_led="R1000H:green:power"
		;;
	adb,a4001n)
		status_led="A4001N:green:power"
		;;
	adb,a4001n1)
		status_led="A4001N1:green:power"
		;;
	adb,av4202n)
		status_led="AV4202N:white:power"
		;;
	asmax,ar-1004g)
		status_led="AR1004G:green:power"
		;;
	brcm,bcm963281tan)
		status_led="963281TAN::power"
		;;
	brcm,bcm96328avng)
		status_led="96328avng::power"
		;;
	brcm,bcm96348gw)
		status_led="96348GW:green:power"
		;;
	brcm,bcm96348gw-11)
		status_led="96348GW-11:green:power"
		;;
	bt,home-hub-2-a)
		status_led="HOMEHUB2A:green:upgrading"
		status_led2="HOMEHUB2A:blue:upgrading"
		;;
	bt,voyager-2110)
		status_led="V2110:power:green"
		;;
	comtrend,ar-5315u)
		status_led="AR-5315u:green:power"
		;;
	comtrend,ar-5381u)
		status_led="AR-5381u:green:power"
		;;
	comtrend,ar-5387un)
		status_led="AR-5387un:green:power"
		;;
	comtrend,ct-536plus)
		status_led="CT536_CT5621:green:power"
		;;
	comtrend,vr-3025u)
		status_led="VR-3025u:green:power"
		;;
	comtrend,vr-3025un)
		status_led="VR-3025un:green:power"
		;;
	comtrend,vr-3026e)
		status_led="VR-3026e:green:power"
		;;
	comtrend,wap-5813n)
		status_led="WAP-5813n:green:power"
		;;
	d-link,dsl-2640b-b)
		status_led="D-4P-W:green:power"
		;;
	d-link,dsl-274xb-c2|\
	d-link,dsl-274xb-f1)
		status_led="dsl-274xb:green:power"
		;;
	d-link,dsl-275xb-d1)
		status_led="dsl-275xb:green:power"
		;;
	dynalink,rta770bw)
		status_led="RTA770BW:green:diag"
		;;
	dynalink,rta770w)
		status_led="RTA770W:green:diag"
		;;
	huawei,echolife-hg520v)
		status_led="HW520:green:net"
		;;
	huawei,echolife-hg553)
		status_led="HW553:blue:power"
		;;
	huawei,echolife-hg556a-a|\
	huawei,echolife-hg556a-b|\
	huawei,echolife-hg556a-c)
		status_led="HW556:red:power"
		;;
	huawei,echolife-hg655b)
		status_led="HW65x:green:power"
		;;
	inventel,livebox-1)
		status_led="Livebox1:red:adsl-fail-power"
		;;
	netgear,cvg834g)
		status_led="CVG834G:green:power"
		;;
	netgear,dgnd3700-v1)
		status_led="DGND3700v1_3800B:green:power"
		;;
	netgear,evg2000)
		status_led="EVG2000:green:power"
		;;
	nucom,r5010un-v2)
		status_led="R5010UNv2:green:power"
		;;
	observa,vh4032n)
		status_led="VH4032N:blue:power"
		;;
	sagem,fast-2504n)
		status_led="fast2504n:green:ok"
		;;
	sagem,fast-2704n)
		status_led2="F@ST2704N:red:power"
		;;
	sagem,fast-2704-v2)
		status_led="F@ST2704V2:green:power"
		;;
	sercomm,ad1018-nor)
		status_led="AD1018:green:power"
		;;
	sky,sr102)
		status_led="SR102:white:power"
		status_led2="SR102:red:power"
		;;
	t-com,speedport-w-303v)
		status_led="spw303v:green:power+adsl"
		;;
	t-com,speedport-w-500v)
		status_led="SPW500V:green:power"
		;;
	tecom,gw6200)
		status_led="GW6200:green:line1"
		status_led2="GW6200:green:tel"
		;;
	telsey,cpva642)
		status_led="CPVA642:green:power:"
		;;
	zyxel,p870hw-51a-v2)
		status_led="P870HW-51a:green:power"
		;;
	esac

	case "$1" in
	preinit)
		status_led_blink_preinit
		;;
	failsafe)
		status_led_blink_failsafe
		;;
	preinit_regular)
		status_led_blink_preinit_regular
		;;
	done)
		if [ "${status_led/power}" != "$status_led" ]; then
			status_led_on
		else
			status_led_off
		fi
		;;
	esac