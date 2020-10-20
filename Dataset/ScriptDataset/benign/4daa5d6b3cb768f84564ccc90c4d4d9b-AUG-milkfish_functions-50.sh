
    echo ":t_uac_dlg:openser_fifo_replies
MESSAGE
$1
.
From: sip:mf@$(nvram get sip_domain)
To: $1
foo: bar_special_header
x: y
p_header: p_value
Contact: <sip:devnull@$(nvram get sip_domain):9>
Content-Type: text/plain; charset=UTF-8" > /tmp/msg;
    echo "." >> /tmp/msg;
    echo "$2 $3 $4 $5 $6 $7 $8 $9 $10 $11 $13 $14 $15" >> /tmp/msg;
    echo "." >> /tmp/msg;
    echo "EOF" >> /tmp/msg;
    #cat /tmp/msg;
    mkfifo -m 666 /tmp/openser_fifo_replies;
    cat /tmp/msg > /tmp/openser_fifo;
    sleep 2;
    #cat /tmp/openser_fifo_replies # > /dev/null;
    rm /tmp/openser_fifo_replies;

