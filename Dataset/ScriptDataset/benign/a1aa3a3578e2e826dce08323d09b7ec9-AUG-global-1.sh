	sku=`cbtinfo r sku`
	
	nvram_set $Platform2 CountryCode $sku
	nvram_set $Platform5 CountryCode $sku
