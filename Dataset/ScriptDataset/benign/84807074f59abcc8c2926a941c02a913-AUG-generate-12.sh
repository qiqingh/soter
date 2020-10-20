	local cg="$1"
	local iptrules
	local pktrules
	local sizerules
	enum_classes "$cg"
	add_rules iptrules "$ctrules" "iptables -t mangle -A qos_${cg}_ct"
	config_get classes "$cg" classes
	for class in $classes; do
		config_get mark "$class" classnr
		config_get maxsize "$class" maxsize
		[ -z "$maxsize" -o -z "$mark" ] || {
			add_insmod xt_length
			append pktrules "iptables -t mangle -A qos_${cg} -m mark --mark $mark/0x0f -m length --length $maxsize: -j MARK --set-mark 0/0xff" "$N"
		}
	done
	add_rules pktrules "$rules" "iptables -t mangle -A qos_${cg}"
	for iface in $INTERFACES; do
		config_get classgroup "$iface" classgroup
		config_get device "$iface" device
		config_get ifbdev "$iface" ifbdev
		config_get upload "$iface" upload
		config_get download "$iface" download
		config_get halfduplex "$iface" halfduplex
		download="${download:-${halfduplex:+$upload}}"
		append up "iptables -t mangle -A OUTPUT -o $device -j qos_${cg}" "$N"
		append up "iptables -t mangle -A FORWARD -o $device -j qos_${cg}" "$N"
	done
	cat <<EOF
$INSMOD
iptables -t mangle -N qos_${cg} >&- 2>&-
iptables -t mangle -N qos_${cg}_ct >&- 2>&-
${iptrules:+${iptrules}${N}iptables -t mangle -A qos_${cg}_ct -j CONNMARK --save-mark --mask 0xff}
iptables -t mangle -A qos_${cg} -j CONNMARK --restore-mark --mask 0xff
iptables -t mangle -A qos_${cg} -m mark --mark 0/0x0f -j qos_${cg}_ct
$pktrules
${iptrules:+${iptrules}${N}iptables -t mangle -A qos_${cg} -j CONNMARK --save-mark --mask 0xf0}
$up$N${down:+${down}$N}
EOF
	unset INSMOD
