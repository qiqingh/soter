#!/bin/sh
PPP_PEERS_DIRECTORY=/etc/ppp/peers
PPPOE_PEERS_FILE=$PPP_PEERS_DIRECTORY"/utopia-pppoe"
PPP_OPTIONS_FILE=/etc/ppp/options
PPP_CHAP_SECRETS_FILE=/etc/ppp/chap-secrets
PPP_PAP_SECRETS_FILE=/etc/ppp/pap-secrets
BP_CONNECTED_SCRIPT=/tmp/bp-connected
BP_DISCONNECTED_SCRIPT=/tmp/bp-disconnected
