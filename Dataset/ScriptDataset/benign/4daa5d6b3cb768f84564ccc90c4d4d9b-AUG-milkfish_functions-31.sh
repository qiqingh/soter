    dbtextctl rm $1 | grep USER &&\
    milkfish_services audit openser noexit &&\
    openserctl stop && sleep 3 && openserctl start
