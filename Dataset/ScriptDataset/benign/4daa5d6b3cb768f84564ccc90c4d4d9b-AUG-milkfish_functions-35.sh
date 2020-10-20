    [ -d /var/openser ] &&\
    milkfish_services openserctl stop &&\
    mf_feedback "Flushing volatile SIP database..." &&\
    cp /etc/openser/dbtext/uri.empty /var/openser/dbtext/uri &&\
    cp /etc/openser/dbtext/grp.empty /var/openser/dbtext/grp &&\
    cp /etc/openser/dbtext/aliases.empty /var/openser/dbtext/aliases &&\
    cp /etc/openser/dbtext/location.empty /var/openser/dbtext/location &&\
    cp /etc/openser/dbtext/subscriber.empty /var/openser/dbtext/subscriber &&\
    #cp /etc/openser/dbtext/version.empty /var/openser/dbtext/version &&\
    sleep 5 && openserctl start
