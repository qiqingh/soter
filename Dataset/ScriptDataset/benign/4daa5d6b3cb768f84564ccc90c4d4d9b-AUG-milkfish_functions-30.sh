    dbtextctl add $1 $2 $(nvram get milkfish_fromdomain) &&\
    milkfish_services audit openser noexit &&\
    openserctl stop && sleep 3 && openserctl start
