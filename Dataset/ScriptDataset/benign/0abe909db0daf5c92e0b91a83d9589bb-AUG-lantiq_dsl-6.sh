	local val=$1
	local a
	local b

	a=$(expr $val / 100)
	b=$(expr $val % 100)
	printf "%d.%d ms" ${a} ${b}
