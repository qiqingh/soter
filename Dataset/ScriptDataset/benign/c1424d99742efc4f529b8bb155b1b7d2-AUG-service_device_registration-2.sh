   cat > $TOKEN_REFRESH_CRONFILE << EOF
#!/bin/sh
sysevent set refresh_token
EOF
   chmod 700 $TOKEN_REFRESH_CRONFILE
