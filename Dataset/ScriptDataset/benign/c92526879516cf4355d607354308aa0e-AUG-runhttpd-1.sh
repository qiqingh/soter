    install ../lib/libtmConfigClient.so /usr/lib
    install ../lib/libqDecoder.so /usr/lib
    ldconfig
    ${BINDIR}/$HTTPD ${MINI_ARG} &
