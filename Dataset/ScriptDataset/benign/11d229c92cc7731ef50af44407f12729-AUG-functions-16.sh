	for m in $*; do
		if [ -f /etc/modules.d/$m ]; then
			sed 's/^[^#]/insmod &/' /etc/modules.d/$m | ash 2>&- || :
		else
			modprobe $m || :
		fi
	done
