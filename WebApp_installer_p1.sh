#!/bin/bash -eu

# The BSD License

# print each command before executing
#set -x

user_name=$(whoami)
host_name=$(hostname)
dumdum_pass='123'
echo "#######################################################################################################################"

echo ""
echo ">>> {Starting Menna's Superdupper Website Installation - Part One}"
echo ""

echo "#######################################################################################################################"

echo ">>> {Step 0: Remove Essential Programs (Unrequired Versions) and Their Dependencies}"
echo ""

echo ">>> {Removing nodejs, php, composer, npm, mysql-server, and apache2...}"
echo ""
sudo apt purge nodejs php composer npm mysql-server apache2
echo ">>> {Done: Removal Successful}"
echo ""

echo ">>> {Removing Dependencies...}"
echo ""
sudo apt autoremove
echo ">>> {Done: Removal Successful}"
echo ""

echo "#######################################################################################################################"

echo ">>> {Step 1: Update and Upgrade Packages}"
echo ""

echo ">>> {Updating Packages...}"
echo ""
sudo apt update
echo ">>> {Done: Update Successful}"
echo ""

# TODO: see if upgrading like this sets curl up

echo ">>> {Upgrading Packages...}"
echo ""
# sudo apt install curl -y
# sudo apt install git -y
# sudo apt install net-tools
sudo apt upgrade -y
echo ">>> {Done: Upgrade Successful}"
echo ""

echo "#######################################################################################################################"

echo ">>> {Step 2: Install Apache Web Server}"
echo ""

echo ">>> {Installing apache2...}"
echo ""
sudo apt install apache2 -y
echo ">>> {Done: Installation Successful}"
echo ""

echo ">>> {Starting apache2...}"
echo ""
sudo systemctl start apache2
echo ">>> {Done: Started Successfully}"
echo ""

echo ">>> {Enabling apache2 at Boot Time...}"
echo ""
sudo systemctl enable apache2
echo ">>> {Done: Enabled Successfully}"
echo ""

echo ">>> {Checking If apache Runs Without Errors...}"
echo ""
sudo systemctl status apache2
echo ">>> {Done: Enabled Successfully}"
echo ""

echo ">>> {Please Make Sure That Apache Runs Without Errors---Read The Previously-printed Message Carefully}"
echo ""
read -p "Press 'Enter' to Continue"
echo ""

echo "#######################################################################################################################"

echo ">>> {Step 3: Install MySQL Server}"
echo ""

echo ">>> {Installing mysql-server...}"
echo ""
sudo apt install mysql-server -y
sudo mysql_secure_installation 
echo ">>> {Done: Installation Successful}"
echo ""

echo "#######################################################################################################################"

echo ">>> {Step 4: Install PHP8.1 From Source}"
echo ""

echo ">>> {Installing Required Dependencies...}"
echo ""
sudo apt install -y build-essential libxml2-dev libsqlite3-dev curl libcurl4-openssl-dev pkg-config libssl-dev libonig-dev libzip-dev zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev libgmp-dev libpq-dev libicu-dev libbz2-dev libxpm-dev libwebp-dev libtidy-dev libxslt1-dev
echo ">>> {Done: Installation Successful}"
echo ""

echo ">>> {Downloading PHP Source Code...}"
echo ""
wget https://www.php.net/distributions/php-8.1.0.tar.gz
echo ">>> {Done: Download Successful}"
echo ""

echo ">>> {Extracting the Downloaded File...}"
echo ""
tar -xzf php-8.1.0.tar.gz
echo ">>> {Done: Extraction Successful}"
echo ""

echo ">>> {Configuring PHP Build Environment...}"
echo ""
cd php-8.1.0
./configure --prefix=/usr/local/php --with-openssl --with-zlib --enable-bcmath --with-bz2 --enable-calendar --with-curl --enable-exif --enable-ftp --with-gd --enable-mbstring --with-mysqli --with-pdo-mysql --enable-soap --enable-sockets --enable-sysvsem --enable-sysvshm --enable-shmop --with-tidy --with-xmlrpc --with-xsl --enable-zip --with-pear --with-webp --with-jpeg --with-xpm --with-freetype --enable-intl
echo ">>> {Done: Configuration Successful}"
echo ""

echo ">>> {Compiling and Installing PHP (This may take a while)...}"
echo ""
make
sudo make install
echo ">>> {Done: Installation Successful}"
echo ""

echo ">>> {Updating System Path...}"
echo ""
echo 'export PATH="/usr/local/php/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
echo ">>> {Done: Updated Successfully}"
echo ""

echo ">>> {Checking PHP Version...}"
echo ""
cd
php -v
echo ">>> {Please Make Sure That PHP is The Correct Version---8.1.x}"
echo ""
read -p "Press 'Enter' to Continue"

echo "#######################################################################################################################"

echo ">>> {Step 5: Install Composer}"
echo ""

echo ">>> {Installing composer...}"
echo ""
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
echo ">>> {Done: Installation Successful}"
echo ""

echo ">>> {Checking composer Version...}"
echo ""
composer --version
echo ">>> {Please Make Sure That Composer is The Correct Version---2.6.x}"
echo ""
read -p "Press 'Enter' to Continue"

echo "#######################################################################################################################"

echo ">>> {Step 6: Install Laravel10}"
echo ""

echo ">>> {Installing laravel...}"
echo ""
composer global require laravel/installer
echo ">>> {Done: Installation Successful}"
echo ""

echo ">>> {Updating Path...}"
echo ""
export PATH="$PATH:$HOME/.config/composer/vendor/bin"
echo ">>> {Done: Update Successful}"
echo ""

echo "#######################################################################################################################"

echo ">>> {Step 7: Install npm v8.11.0 && nodejs v16.15.1}"
echo ""

echo ">>> {Installing Node Version Manager (nvm)...}"
echo ""
cd
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.bashrc
echo ">>> {Done: Installation Successful}"
echo ""

echo ">>> {Installing Nodejs v16.15.1...}"
echo ""
nvm install 16.15.1
nvm use 16.15.1
echo ">>> {Done: Installation Successful}"
echo ""

echo ">>> {Installing npm v8.11.0...}"
echo ""
npm install -g npm@8.11.0
echo ">>> {Done: Installation Successful}"
echo ""

echo ">>> {Checking nodejs && npm Versions...}"
echo ""
node -v
npm -v
echo ">>> {Please Make Sure That The Correct Versions were installed---v16.15.1 for nodejs and v8.11.0 for npm}"
echo ""
read -p "Press 'Enter' to Continue"

echo "#######################################################################################################################"

echo ">>> {Step 8: Create MySQL user for Laravel API}"
echo ""

echo ">>> {Logging in to MySQL as Admin...}"
echo ""
echo ">>> {Please Enter the Following Lines in Sequence Upon Entry}"
echo ""
echo ">>> {CREATE USER '$user_name'@'localhost' IDENTIFIED BY '$dumdum_pass';}"
echo ""
echo ">>> {GRANT ALL PRIVILEGES ON *.* TO '$user_name'@'localhost';}"
echo ""
echo ">>> {FLUSH PRIVILEGES;}"
echo ""
echo ">>> {EXIT;}"
echo ""
echo ">>> {Start the Second Part of the Script Upon Exit to Resume Installation}"
echo ""
sudo mysql

# To be Continued in Part 2!

