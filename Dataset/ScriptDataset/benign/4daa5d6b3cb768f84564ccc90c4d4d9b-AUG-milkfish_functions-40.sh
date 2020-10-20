    [ -d /var/openser/dbtext ] &&\
    mf_feedback "Restoring SIP subscriber database from NVRAM..."
    if [ ! -z "$(nvram get milkfish_subscriber)" ]; then 
	nvram get milkfish_subscriber | sed -e 's/<+>/\n/g;s/<->/ /g' > /var/openser/dbtext/subscriber
	echo "Done."
    else
	echo "Empty."
    fi
    mf_feedback "Restoring SIP aliases database from NVRAM..."
    if [ ! -z "$(nvram get milkfish_aliases)" ]; then 
	nvram get milkfish_aliases | sed -e 's/<+>/\n/g;s/<->/ /g' > /var/openser/dbtext/aliases
	echo "Done."
    else
	echo "Empty."
    fi
    #milkfish_services openserctl restart
