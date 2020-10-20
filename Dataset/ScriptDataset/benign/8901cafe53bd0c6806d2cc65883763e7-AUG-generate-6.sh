	local c="0"
	config_get classes "$1" classes
	config_get default "$1" default
	for class in $classes; do
		c="$(($c + 1))"
		config_set "${class}" classnr $c
		case "$class" in
			$default) class_default=$c;;
		esac
	done
	class_default="${class_default:-$c}"
