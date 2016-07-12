#!/bin/bash

sudo locale-gen UTF-8

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
	apt-get install libapache2-mod-php5
	a2enmod rewrite

echo "Installing PHP"
    apt-get install php5-common php5-dev php5-cli php5-fpm -y php5enmod mcrypt 
    a2enmod headers
    
echo "Installing PHP extensions"
    apt-get install curl php5-curl php5-gd php5-mcrypt php5-mysql -y 

# Set up Apache Virtual host

echo -e "\n--- Add apache Vhost ---\n"

cat > /etc/apache2/sites-enabled/000-default.conf <<EOF

<VirtualHost *:80>

ServerName www.cucusportsapi.com
ServerAdmin webmaster@localhost
DocumentRoot /var/www/cucuApi/public
<Directory "/var/www/cucuApi/public">
      Options FollowSymLinks
      AllowOverride All
	  Order allow,deny
      Allow from all
  </Directory>

ErrorLog ${APACHE_LOG_DIR}/error.log
CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

#!/usr/bin/env bash



#Restart services

echo -e "\n--- Restart services ---\n"

service apache2 restart


service mysql restart