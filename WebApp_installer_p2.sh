#!/bin/bash -eu

# The BSD License

# print each command before executing
#set -x

user_name=$(whoami)
host_name=$(hostname)
dumdum_pass='123'

echo "#######################################################################################################################"

echo ""
echo ">>> {Starting Menna's Superdupper Website Installation - Part Two}"
echo ""

echo "#######################################################################################################################"

echo ">>> {Step 9: Clone Backend Repository (GP_laravel)}"
echo ""

echo ">>> {Cloning Repository...}"
echo ""
cd ~
git clone https://github.com/meh-land/GP_laravel.git
cd GP_laravel
echo ">>> {Done: Cloning Successful}"
echo ""

echo ">>> {Installing...}"
echo ""
echo ">>> {If you were asked to create a database, say yes}"
echo ""
composer install
cp .env.example .env
echo ">>> {Done: Installation Successful}"
echo ""

echo ">>> {Editing Environment Variables...}"
echo ""
sed -i '/DB_USERNAME=/c\DB_USERNAME='${user_name}'' /home/${user_name}/GP_laravel/.env
sed -i '/DB_PASSWORD=/c\DB_PASSWORD='${dumdum_pass}'' /home/${user_name}/GP_laravel/.env
echo ">>> {Done: Edited Successfully}"
echo ""

echo ">>> {Adjusting Final Settings...}"
echo ""
php artisan key:generate
php artisan migrate
echo ">>> {Done: Adjustments Successful}"
echo ""

echo "#######################################################################################################################"

echo ">>> {Step 10: Clone Frontend Repository (Dashboard)}"
echo ""

echo ">>> {Cloning Repository...}"
echo ""
cd ~
git clone https://github.com/meh-land/Dashboard.git
cd Dashboard
echo ">>> {Done: Cloning Successful}"
echo ""

echo ">>> {Installing...}"
echo ""
npm install
echo ">>> {Done: Installation Successful}"
echo ""

echo "#######################################################################################################################"



















