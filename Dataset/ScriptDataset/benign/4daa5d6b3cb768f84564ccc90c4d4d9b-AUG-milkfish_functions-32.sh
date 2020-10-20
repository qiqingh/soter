    [ -e /var/openser/dbtext/aliases ] && ALIASES_FILE=/var/openser/dbtext/aliases || ALIASES_FILE=/etc/openser/dbtext/aliases
    echo "$1::$2::0:1.00:Milkfish-Alias:42::0:0:128:Milkfish-Router:" >> "$ALIASES_FILE"
    milkfish_services audit openser noexit &&\
    openserctl stop && sleep 3 && openserctl start
