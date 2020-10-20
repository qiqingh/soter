	local a=$(expr $1 / 10)
	local b=$(expr $1 % 10)
	echo "${a}.${b#-}"
