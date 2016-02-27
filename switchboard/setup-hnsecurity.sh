
## Gen Certs


## Install and Run NGINX
cd /tmp/
wget https://varunc1961-8000.terminal.com/nginx.tgz
sudo tar -C/ -xzvf /tmp/nginx.tgz
wget https://raw.githubusercontent.com/terminalcloud/dotfiles/master/switchboard/nginx-code/nginx-node.conf
sudo mv nginx-node.conf /usr/local/nginx/nginx.conf
/usr/local/nginx/nginx



## Setup Password
echo 'deb http://s3-us-west-1.amazonaws.com/cloudlabs.apt.repo/production /' | sudo tee -a /etc/apt/sources.list
sudo apt-get update
sudo apt-get install web-terminal
sudo web-terminal start

## Setup IDE 


## More !? 
