    [ -e /var/openser/dbtext/subscriber ] && mf_feedback "Storing volatile SIP DB subscribers to NVRAM..." &&\
    nvram set milkfish_subscriber=$(cat /var/openser/dbtext/subscriber | head -n11 | sed -e ':a;N;$!ba;s/\n/<+>/g;s/ /<->/g') &&\
    echo "Done."
    [ -e /var/openser/dbtext/aliases ] && mf_feedback "Storing volatile SIP DB aliases to NVRAM..." &&\
    nvram set milkfish_aliases=$(cat /var/openser/dbtext/aliases | head -n11 | sed -e ':a;N;$!ba;s/\n/<+>/g;s/ /<->/g') &&\
    echo "Done."
