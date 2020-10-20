    [ -e /var/openser/dbtext/aliases ] && ALIASES_FILE=/var/openser/dbtext/aliases || ALIASES_FILE=/etc/openser/dbtext/aliases
    touch "$ALIASES_FILE".tmp
    grep -v ^"$1" "$ALIASES_FILE" >> "$ALIASES_FILE".tmp
    mv "$ALIASES_FILE".tmp "$ALIASES_FILE"
    milkfish_services audit openser noexit &&\
    openserctl stop && sleep 3 && openserctl start
