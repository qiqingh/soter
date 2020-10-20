	switch reg w 14 5555
	switch reg w 40 1001
	switch reg w 44 1001
	switch reg w 48 1001
	switch reg w 4c 1
	switch reg w 50 2001
	switch reg w 70 ffffffff
	switch reg w 98 7f7f
	switch reg w e4 7f
	
	#clear mac table if vlan configuration changed
	switch clear
