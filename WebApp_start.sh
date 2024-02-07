#!/bin/bash -eu

# The BSD License

# print each command before executing
#set -x

user_name=$(whoami)
host_name=$(hostname)
dumdum_pass='123'
backend_dir='/home/$user_name/GP_laravel'
frontend_dir='/home/$user_name/Dashboard'
machine_ip='192.168.100.106'

echo "#######################################################################################################################"

echo ""
echo ">>> {Starting Menna's Superdupper Web Application}"
echo ""

echo "#######################################################################################################################"


echo ">>> {Step 1: Start Backend}"
echo ""

echo ">>> {Checking IP Address}"
echo ""
ifconfig
echo ">>> {Make Sure to Check your Machine's IP Address Before Continuing}"
echo ""
read -p "Press 'Enter' to Continue"
echo ""

echo ">>> {Starting in the Backend in the Background...}"
echo ""
cd $backend_dir
php artisan serve --host=$machine_IP &
echo ">>> {Done: Backend Started Successfully}"
echo ""

echo "#######################################################################################################################"

echo ">>> {Step 2: Start Frontend}"
echo ""

echo ">>> {Starting in the Frontend in the Background...}"
echo ""
cd $frontend_dir
npm start &
echo ">>> {Done: Frontend Started Successfully}"
echo ""

echo "#######################################################################################################################"
