

DIRECTORY=/etc/cloudlabs/certs

## Check if master exists do not over write

if [  -f "$DIRECTORY/ca.key" ]; then 
  echo "You already have a CA KEY, replacing will result in broken SSL to clients "
  exit 1;
fi

if [  -f "$DIRECTORY/ca.crt" ]; then 
  echo "You already have a CA CRT, replacing will result in broken SSL to clients "; 
  exit 1;
fi

if [ ! -d "$DIRECTORY" ]; then
  mkdir -p $DIRECTORY; 
fi



# Create the CA Key and Certificate
# This will mainly be use for signing Client Certs but can be used for anything                       
openssl genrsa -out $DIRECTORY/ca.key 4096                                                                                                     openssl req -new -x509 -days 365 -key $DIRECTORY/ca.key -out $DIRECTORY/ca.crt  
