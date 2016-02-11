

if [ "$1" == "-h" ]; then
  echo "Usage: `basename $0` <FQDN> (ie domain name)"
          exit 0
fi

if [[ -z "$1" ]] ; then
      echo "Usage: `basename $0` <SERVER DOMAIN REQUIRED>"
      exit 0
fi


# Create the CA Key and Certificate for signing Client Certs
openssl genrsa -out ca.key 4096
openssl req -new -x509 -days 365 -key ca.key -out ca.crt

# Create the Server Key, CSR, and Certificate
openssl genrsa -out server.key 1024
openssl req -new -key server.key -out server.csr \
    -subj "/C=CA/ST=Harrison/L=Leamington/O=Cloudlabs/OU=TalkToAnuraag/CN=$1"

# We're self signing our own server cert here. This is a no-no in production.
openssl x509 -req -days 365 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out server.crt



