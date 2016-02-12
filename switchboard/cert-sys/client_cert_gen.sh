
BASEDIR=/etc/cloudlabs/certs
DIRECTORY=/etc/cloudlabs/certs/clients
USER=root

if [ "$1" == "-h" ]; then
    echo "Usage: `basename $0` <IP> <Pem Path> <User>"
    exit 0
fi

if [[ -z "$1" ]] ; then
    echo "Usage: `basename $0` <IP> is required"
    exit 0
fi

if [[ -z "$2" ]]; then
    echo "$Usage: `basename $0` <IP> <Pem Path> is required"
    exit 0
fi

if [[ ! -z "$3" ]]; then
    USER=$3
fi

if [ ! -f "$BASEDIR/ca.crt" ]; then
    echo "No CA Available , first generate master CA";
    exit 1;
fi

if [ ! -d "$BASEDIR/clients" ]; then
   mkdir -p $BASEDIR/clients	    
fi

CAKEY=/etc/cloudlabs/certs/ca.key
CACRT=/etc/cloudlabs/certs/ca.crt

# Create the Client Key and CSR
openssl genrsa -out $DIRECTORY/$1.key 1024
openssl req -new -key $DIRECTORY/$1.key -out $DIRECTORY/$1.csr -subj "/C=CA/ST=Harrison/L=Leamington/O=Cloudlabs/OU=TalkToAnuraag/CN=$1"


# Sign the client certificate with our CA cert.  Unlike signi:wqng our own server cert, this is what we want to do.
openssl x509 -req -days 365 -in $DIRECTORY/$1.csr -CA $CACRT -CAkey $CAKEY -set_serial 01 -out $DIRECTORY/$1.crt

ssh -i $2 $3@$1 "mkdir -p /etc/cloudlabs/certs" 

scp -p -i $2 /etc/cloudlabs/certs/clients/$1.key $3@$1:/etc/cloudlabs/certs/client.key
scp -p -i $2 /etc/cloudlabs/certs/clients/$1.crt $3@$1:/etc/cloudlabs/certs/client.crt

