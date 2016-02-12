#!/bin/bash


if [ "$1" == "-h" ]; then
    echo "Usage: `basename $0` <FDQN>"
    exit 0
fi

if [[ -z "$1" ]] ; then
    echo "Usage: `basename $0` <FDQN> is required"
    exit 0
fi

DIRECTORY=/etc/cloudlabs/certs

CAKEY="$DIRECTORY/ca.key"
CACRT="$DIRECTORY/ca.crt"

SRVKEY="$DIRECTORY/server.key"
SRVCSR="$DIRECTORY/server.csr"
SRVCRT="$DIRECTORY/server.crt"

# Create the Server Key, CSR, and Certificate
openssl genrsa -out $SRVKEY 1024
openssl req -new -key $SRVKEY -out $SRVCSR \
    -subj "/C=CA/ST=Harrison/L=Leamington/O=Cloudlabs/OU=TalkToAnuraag/CN=$1"

# We're self signing our own server cert here. This is a no-no in production.
openssl x509 -req -days 365 -in $SRVCSR -CA $CACRT -CAkey $CAKEY -set_serial 01 -out $SRVCRT



