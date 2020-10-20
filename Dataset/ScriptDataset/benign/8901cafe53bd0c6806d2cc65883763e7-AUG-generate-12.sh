	local cg="$1"
	local iptrules
	local pktrules
	local sizerules
	enum_classes "$cg"
	for command in $iptables; do
		add_rules iptrules "$ctrules" "$command -w -t mangle -A qos_${cg}_ct"
	done
	config_get classes "$cg" classes
	for class in $classes; do
		config_get mark "$class" classnr
		config_get maxsize "$class" maxsize
		[ -z "$maxsize" -o -z "$mark" ] || {
			add_insmod xt_length
			for command in $iptables; do
				append pktrules "$command -w -t mangle -A qos_${cg} -m mark --mark $mark/0x0f -m length --length $maxsize: -j MARK --set-mark 0/0xff" "$N"
			done
		}
	done
	for command in $iptables; do
		add_rules pktrules "$rules" "$command -w -t mangle -A qos_${cg}"
	done
	for iface in $INTERFACES; do
		config_get classgroup "$iface" classgroup
		config_get device "$iface" device
		config_get ifbdev "$iface" ifbdev
		config_get upload "$iface" upload
		config_get download "$iface" download
		config_get halfduplex "$iface" halfduplex
		download="${download:-${halfduplex:+$upload}}"
		for command in $iptables; do
			append up "$command -w -t mangle -A OUTPUT -o $device -j qos_${cg}" "$N"
			append up "$command -w -t mangle -A FORWARD -o $device -j qos_${cg}" "$N"
		done
	done
	cat <<EOF
$INSMOD
EOF
  
for command in $iptables; do
	cat <<EOF
	$command -w -t mangle -N qos_${cg} 
	$command -w -t mangle -N qos_${cg}_ct
EOF
done
cat <<EOF
	${iptrules:+${iptrules}${N}}
EOF
for command in $iptables; do
	cat <<EOF
	$command -w -t mangle -A qos_${cg}_ct -j CONNMARK --save-mark --mask 0xff
	$command -w -t mangle -A qos_${cg} -j CONNMARK --restore-mark --mask 0x0f
	$command -w -t mangle -A qos_${cg} -m mark --mark 0/0x0f -j qos_${cg}_ct
EOF
done
cat <<EOF
$pktrules
EOF
for command in $iptables; do
	cat <<EOF
	$command -w -t mangle -A qos_${cg} -j CONNMARK --save-mark --mask 0xff
EOF
done
cat <<EOF
$up$N${down:+${down}$N}
EOF
	unset INSMOD
