    [ -d /var/openser ] &&\
    milkfish_services openserctl stop &&\
    mf_feedback "Restoring persistent SIP database..." &&\
    cp /etc/openser/dbtext/uri /var/openser/dbtext/ &&\
    cp /etc/openser/dbtext/grp /var/openser/dbtext/ &&\
    cp /etc/openser/dbtext/aliases /var/openser/dbtext/ &&\
    cp /etc/openser/dbtext/location /var/openser/dbtext/ &&\
    cp /etc/openser/dbtext/subscriber /var/openser/dbtext/ &&\
    cp /etc/openser/dbtext/version /var/openser/dbtext/ &&\
    sleep 5 && openserctl start
