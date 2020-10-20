	APP=$1
	echo "usage: $1 command args..."
	echo
	echo "commands:"
	echo " list - list all policies"
	echo "   ex) $1 list"
	echo
	echo " get - display the policy"
	echo "   arg1 - policy"
	echo "   ex) $1 get 1                  # show policy 1."
	echo
	echo " preset - set predefined policies. Existing polcies will be overwritten"
	echo "   ex) $1 preset"
	echo
	echo " set_number - set policy number."
	echo "   arg1 - policy"
	echo "   arg2 - number. 1~256"
	echo "   ex) $1 set_number 1 10         # set policy 1's number to 10 "
	echo
	echo " set_name - set name"
	echo "   arg1 - policy"
	echo "   arg2 - name in string"
	echo "   ex) $1 set_name 1 test         # set policy 1's name to test "
	echo
	echo " set_status - set policy status. Unused"
	echo "   arg1 - policy"
	echo "   arg2 - status. enable/disable"
	echo "   ex) $1 set_status 1 enable     # enable policy 1"
	echo
	echo " set_sws - set policy safe web surfing"
	echo "   arg1 - policy"
	echo "   arg2 - 0(disable), 1(enable)"
	echo "   ex) $1 set_sws 1 1             # enable safe web surfing of policy 1"
	echo
	echo " set_cat - set policy bad category"
	echo "   arg1 - policy"
	echo "   arg[2:n] - category list. 1~88(category), [1:88]-[1:88](category's start and end)"
	echo "   ex) $1 set_cat 1 1 2-5 10 11 40-50"
	echo "       $1 set_cat 1               # clear bad categories"
	echo
	echo " set_mon - set monday's time schedule"
	echo " set_tue - set tuesday's time schedule"
	echo " set_wed - set wednesday's time schedule"
	echo " set_thr - set thursday's time schedule"
	echo " set_fri - set friday's time schedule"
	echo " set_sat - set saturday's time schedule"
	echo " set_sun - set sunday's time schedule"
	echo "   arg1 - policy"
	echo "   arg[2:n] - blocking time by 30 minutes. 0~47(blocking time), [0:47]-[0:47](blocking time's start and end) "
	echo "   ex) $1 set_mon 1 0-11 42-47    # block 0~6am and 9pm~12am"
	echo "       $1 set_mon 1 28            # block 2pm~2:30pm"
	echo "       $1 set_mon 1               # clear blocking times"
	echo
	echo " set_dev - set policy devices"
	echo "   arg1 - policy"
	echo "   arg[2:n] - pairs of MAC and UUID separated by ','. UUID is optional"
	echo "   ex) $1 set_dev 1 01:02:03:04:05:06,abcdefgh-ijkl-mnop-qrst-uvwxyz123456 0a:0b:0c:0d:0e:0f"
	echo "       $1 set_dev 1               # clear devices"
	echo
	echo " set_blk - set policy blocklist"
	echo "   arg1 - policy"
	echo "   arg[2:n] - url list"
	echo "   ex) $1 set_blk 1 .blocked1.com blocked2.com"
	echo "       $1 set_blk 1               # clear blocked urls"
	echo
	echo " set_wht - set policy whitelist"
	echo "   arg1 - policy"
	echo "   arg[2:n] - url list"
	echo "   ex) $1 set_wht 1 .allowed1.com allowed2.com"
	echo "       $1 set_wht 1               # clear allowed urls"
	echo
	echo " set_port - set blocked ports"
	echo "   arg1 - policy"
	echo "   arg[2:n] - port list(name,protocol,start,end), protocol=both,tcp,udp,none(for icmp)"
	echo "   ex) $1 set_port 1 www,tcp,80,80 ping,none,0,0 dns,udp,53,53"
	echo "       $1 set_port 1               # clear blocked ports"
	echo
	echo " help - show help message"
	echo "   ex) $1 help"
