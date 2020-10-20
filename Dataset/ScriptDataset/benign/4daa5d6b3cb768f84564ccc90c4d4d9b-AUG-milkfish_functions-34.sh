    openserctl ul rm $1 &&\
    milkfish_services audit openser noexit &&\
    openserctl stop && sleep 3 && openserctl start
