	local length=$1
	local offset=$2
	local index=`expr $# - ${length} + 1`
	local data=""

	for j in $(seq ${index} `expr ${length} + ${index} - 1`)
	do
		temp=`eval echo '$'"$j"`
		data=${data}"\x${temp}"
	done

	dd if=${factory_mtd} of=/tmp/Factory.backup
	printf "${data}" | dd conv=notrunc of=/tmp/Factory.backup bs=1 seek=$((${offset}))
	mtd write /tmp/Factory.backup ${factory_name}
	rm -rf /tmp/Factory.backup
