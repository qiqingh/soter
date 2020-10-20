	ret=and(ip,255)
	ip=rshift(ip,8)
	for(;x<3;ret=and(ip,255)"."ret,ip=rshift(ip,8),x++);
	return ret
