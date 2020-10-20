
    echo ":t_uac_dlg:openser_fifo_replies
MESSAGE
$1
.
From: sip:mf@$(nvram get milkfish_fromdomain)
To: $1
foo: bar_special_header
x: y
p_header: p_value
Contact: <sip:devnull@$(nvram get milkfish_fromdomain):9>
Content-Type: text/plain; charset=UTF-8" > /tmp/msg;
    echo "." >> /tmp/msg;
    cat /tmp/sipmessage >> /tmp/msg
    echo "." >> /tmp/msg;
    echo "EOF" >> /tmp/msg;
    #cat /tmp/msg;
    mkfifo -m 666 /tmp/openser_fifo_replies;
    cat /tmp/msg > /tmp/openser_fifo;
    sleep 2;
    #cat /tmp/openser_fifo_replies # > /dev/null;
    rm /tmp/openser_fifo_replies;

