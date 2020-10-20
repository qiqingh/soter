    [ -d /var/openser/dbtext ] &&\
    mf_feedback "Restoring SIP ddsubscriber database from NVRAM..."
    if [ ! -z "$(nvram get milkfish_ddsubscribers)" ]; then 
	echo "#!/bin/sh" > /tmp/restorenvdd.sh
	nvram get milkfish_ddsubscribers | tr ' ' '\n' | awk -F : '{print "dbtextctl add " $1 " " $2 " " "nomail"}'
	nvram get milkfish_ddsubscribers | tr ' ' '\n' | awk -F : '{print "dbtextctl add " $1 " " $2 " " "nomail"}' >> /tmp/restorenvdd.sh
	[ -e /tmp/restorenvdd.sh ] && chmod +x /tmp/restorenvdd.sh && /tmp/restorenvdd.sh && rm /tmp/restorenvdd.sh
	echo "Done."
    else
	echo "Empty."
    fi
    mf_feedback "Restoring SIP ddaliases database from NVRAM..."
    if [ ! -z "$(nvram get milkfish_ddaliases)" ]; then 
	echo "#!/bin/sh" > /tmp/restorenvdd.sh
	[ -e /var/openser/dbtext/aliases ] && nvram get milkfish_ddaliases | tr ' ' '\n' | awk -F : '{print "[ -z \"$(grep " $1 ": /var/openser/dbtext/aliases)\" ] && echo \"" $1 "::sip\\:" $2 "::0:1.00:Milkfish-Alias:42::0:0:128:Milkfish-Router:\" >> /var/openser/dbtext/aliases" }'
	[ -e /var/openser/dbtext/aliases ] && nvram get milkfish_ddaliases | tr ' ' '\n' | awk -F : '{print "[ -z \"$(grep " $1 ": /var/openser/dbtext/aliases)\" ] && echo \"" $1 "::sip\\:" $2 "::0:1.00:Milkfish-Alias:42::0:0:128:Milkfish-Router:\" >> /var/openser/dbtext/aliases" }' >> /tmp/restorenvdd.sh
	[ -e /tmp/restorenvdd.sh ] && chmod +x /tmp/restorenvdd.sh && /tmp/restorenvdd.sh && rm /tmp/restorenvdd.sh
	echo "Done."
    else
	echo "Empty."
    fi
    #milkfish_services openserctl restart
