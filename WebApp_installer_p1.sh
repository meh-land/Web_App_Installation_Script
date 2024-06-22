#!/bin/bash -eu

# This function prints the name of the current running section in a different color
# Useful for debugging and tracing
section () {
	tput setaf 1
	echo $1
	tput sgr0
}

user_name=$USER
host_name=$(hostname)
dumdum_pass='123'
echo "#######################################################################################################################"

echo ""
section ">>> {Starting Menna's Superdupper Website Installation - Part One}"
echo ""

echo "#######################################################################################################################"

section ">>> {Step 0: Remove Essential Programs (Unrequired Versions) and Their Dependencies}"
echo ""

section ">>> {Removing nodejs, php, composer, npm, mysql-server, and apache2...}"
echo ""
sudo apt purge nodejs php composer npm mysql-server apache2
section ">>> {Done: Removal Successful}"
echo ""

section ">>> {Removing Dependencies...}"
echo ""
sudo apt autoremove
section ">>> {Done: Removal Successful}"
echo ""

echo "#######################################################################################################################"

section ">>> {Step 1: Update and Upgrade Packages}"
echo ""

section ">>> {Updating Packages (This may take a while)...}"
echo ""
sudo apt update
section ">>> {Done: Update Successful}"
echo ""

section ">>> {Upgrading Packages (This may take a while)...}"
echo ""
sudo apt install curl -y
sudo apt install git -y
sudo apt install net-tools -y
sudo apt upgrade -y
section ">>> {Done: Upgrade Successful}"
echo ""

echo "#######################################################################################################################"

section ">>> {Step 2: Install Apache Web Server}"
echo ""

section ">>> {Installing apache2...}"
echo ""
sudo apt install apache2 -y
section ">>> {Done: Installation Successful}"
echo ""

section ">>> {Starting apache2...}"
echo ""
sudo systemctl start apache2
section ">>> {Done: Started Successfully}"
echo ""

section ">>> {Enabling apache2 at Boot Time...}"
echo ""
sudo systemctl enable apache2
section ">>> {Done: Enabled Successfully}"
echo ""

section ">>> {Checking If apache Runs Without Errors...}"
echo ""
sudo systemctl status apache2
section ">>> {Done: Enabled Successfully}"
echo ""

section ">>> {Please Make Sure That Apache Runs Without Errors---Read The Previously-printed Message Carefully}"
echo ""
read -p "Press 'Enter' to Continue"
echo ""

echo "#######################################################################################################################"

section ">>> {Step 3: Install MySQL Server}"
echo ""

section ">>> {Installing mysql-server...}"
echo ""
sudo apt install mysql-server -y
sudo mysql_secure_installation 
section ">>> {Done: Installation Successful}"
echo ""

echo "#######################################################################################################################"

section ">>> {Step 4: Install PHP8.1 From Source}"
echo ""

section ">>> {Installing Required Dependencies...}"
echo ""
sudo apt install -y build-essential libxml2-dev libsqlite3-dev curl libcurl4-openssl-dev pkg-config libssl-dev libonig-dev libzip-dev zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev libgmp-dev libpq-dev libicu-dev libbz2-dev libxpm-dev libwebp-dev libtidy-dev libxslt1-dev zip
section ">>> {Done: Installation Successful}"
echo ""

section ">>> {Downloading PHP Source Code...}"
echo ""
cd ~
wget https://www.php.net/distributions/php-8.1.0.tar.gz
section ">>> {Done: Download Successful}"
echo ""

section ">>> {Extracting the Downloaded File...}"
echo ""
tar -xzf php-8.1.0.tar.gz
section ">>> {Done: Extraction Successful}"
echo ""

section ">>> {Configuring PHP Build Environment...}"
echo ""
cd php-8.1.0
./configure --prefix=/usr/local/php --with-openssl --with-zlib --enable-bcmath --with-bz2 --enable-calendar --with-curl --enable-exif --enable-ftp --with-gd --enable-mbstring --with-mysqli --with-pdo-mysql --enable-soap --enable-sockets --enable-sysvsem --enable-sysvshm --enable-shmop --with-tidy --with-xmlrpc --with-xsl --enable-zip --with-pear --with-webp --with-jpeg --with-xpm --with-freetype --enable-intl
section ">>> {Done: Configuration Successful}"
echo ""

section ">>> {Compiling and Installing PHP (This may take a while)...}"
echo ""
make
sudo make install
section ">>> {Done: Installation Successful}"
echo ""

section ">>> {Updating System Path...}"
echo ""
echo 'export PATH="/usr/local/php/bin:$PATH"' >> ~/.bashrc
export PATH="/usr/local/php/bin:$PATH"
source ~/.bashrc
section ">>> {Done: Updated Successfully}"
echo ""

section ">>> {Checking PHP Version...}"
echo ""
cd ~
php -v
section ">>> {Please Make Sure That PHP is The Correct Version---8.1.x}"
echo ""
read -p "Press 'Enter' to Continue"

echo "#######################################################################################################################"

section ">>> {Step 5: Install Composer}"
echo ""

section ">>> {Installing composer...}"
echo ""
cd ~
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
section ">>> {Done: Installation Successful}"
echo ""

section ">>> {Checking composer Version...}"
echo ""
composer --version
section ">>> {Please Make Sure That Composer is The Correct Version---2.6.x}"
echo ""
read -p "Press 'Enter' to Continue"

echo "#######################################################################################################################"

section ">>> {Step 6: Install Laravel10}"
echo ""

section ">>> {Installing laravel...}"
echo ""
cd ~
composer global require laravel/installer
section ">>> {Done: Installation Successful}"
echo ""

section ">>> {Updating Path...}"
echo ""
export PATH="$PATH:$HOME/.config/composer/vendor/bin"
section ">>> {Done: Update Successful}"
echo ""

echo "#######################################################################################################################"

section ">>> {Step 7: Install npm v8.11.0 && nodejs v16.15.1}"
echo ""

section ">>> {Installing Node Version Manager (nvm)...}"
echo ""
cd ~
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.bashrc
section ">>> {Done: Installation Successful}"
echo ""

section ">>> {Installing Nodejs v16.15.1...}"
echo ""
nvm install 16.15.1
nvm use 16.15.1
section ">>> {Done: Installation Successful}"
echo ""

section ">>> {Installing npm v8.11.0...}"
echo ""
npm install -g npm@8.11.0
section ">>> {Done: Installation Successful}"
echo ""

section ">>> {Checking nodejs && npm Versions...}"
echo ""
node -v
npm -v
section ">>> {Please Make Sure That The Correct Versions were installed---v16.15.1 for nodejs and v8.11.0 for npm}"
echo ""
read -p "Press 'Enter' to Continue"

echo "#######################################################################################################################"

section ">>> {Step 8: Create MySQL user for Laravel API}"
echo ""

section ">>> {Logging in to MySQL as Admin...}"
echo ""
section ">>> {Please Enter the Following Lines in Sequence Upon Entry}"
echo ""
section ">>> {CREATE USER '$user_name'@'localhost' IDENTIFIED BY '$dumdum_pass';}"
echo ""
section ">>> {GRANT ALL PRIVILEGES ON *.* TO '$user_name'@'localhost';}"
echo ""
section ">>> {FLUSH PRIVILEGES;}"
echo ""
section ">>> {EXIT;}"
echo ""
section ">>> {Start the Second Part of the Script Upon Exit to Resume Installation}"
echo ""
sudo mysql

# To be Continued in Part 2!

