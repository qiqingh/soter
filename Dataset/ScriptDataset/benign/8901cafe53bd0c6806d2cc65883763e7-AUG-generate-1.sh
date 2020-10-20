	insmod="modprobe"
	rmmod="$insmod -r"
} || {
	insmod="insmod"
	rmmod="rmmod"
