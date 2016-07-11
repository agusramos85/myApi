#!/bin/bash

echo "Updating..."
apt-get update

echo "Upgrading..."
apt-get upgrade

echo "Installing debconf..."
	apt-get install debconf-utils -y

echo "Installing mysql..."
	debconf-set-selections <<< "mysql-server mysql-server/root_password password 1234"    
	debconf-set-selections <<< "mysql-server mysql-server/root_password_again password 1234"	
	apt-get install mysql-server -y

echo "Installing apache..."
	apt-get install apache2 -y

echo "Installing PHP"
    apt-get install php5-common php5-dev php5-cli php5-fpm -y 
    
echo "Installing PHP extensions"
    apt-get install curl php5-curl php5-gd php5-mcrypt php5-mysql -y 