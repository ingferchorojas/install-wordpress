#!/bin/bash

# Load environment variables from file
source env.sh

# Update apt-get
sudo apt-get update

# Install Apache and PHP
sudo apt-get install apache2 php php-mysql libapache2-mod-php -y

# Install MySQL
sudo apt-get install mysql-server -y

# Download and install expect
sudo apt-get install expect -y

# Run expect script to secure MySQL installation
./mysql_secure_install.expect $MYSQL_ROOT_PASSWORD

# Create a MySQL database for WordPress
sudo mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE $wordpress_db_name;"
sudo mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE USER '$wordpress_db_user'@'localhost' IDENTIFIED BY '$wordpress_db_password';"
sudo mysql -u root -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON $wordpress_db_name.* TO '$wordpress_db_user'@'localhost';"
sudo mysql -u root -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

# Download and install WordPress
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar xf latest.tar.gz
sudo mv wordpress /var/www/html/
sudo chown -R www-data:www-data /var/www/html/wordpress
sudo chmod -R 755 /var/www/html/wordpress

# Set up the WordPress configuration file
cd /var/www/html/wordpress/
cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/$wordpress_db_name/" wp-config.php
sed -i "s/username_here/$wordpress_db_user/" wp-config.php
sed -i "s/password_here/$wordpress_db_password/" wp-config.php

# Set up virtual host
sudo sh -c "echo '<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ServerName linuxlat.com
    DocumentRoot /var/www/html/wordpress
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/linuxlat.com.conf"
sudo a2ensite linuxlat.com.conf
sudo systemctl reload apache2

# Clean up
rm -rf /tmp/latest.tar.gz

echo "Installation completed successfully."
