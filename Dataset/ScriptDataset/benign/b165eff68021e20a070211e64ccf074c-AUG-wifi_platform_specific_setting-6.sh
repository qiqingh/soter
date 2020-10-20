	PHY_IF=$1
		is_mbss_needed ${PHY_IF}
		if [ "$?" = "0" ]; then 
			disable_mbss ${PHY_IF}
		fi
