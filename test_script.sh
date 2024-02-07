#!/bin/bash -eu

# The BSD License

# print each command before executing
#set -x

sudo mysql <<EOD
CREATE USER 'nemesis86'@'localhost' IDENTIFIED BY '123';
GRANT ALL PRIVILEGES ON *.* TO 'nemesis86'@'localhost';
FLUSH PRIVILEGES;
EXIT;
EOD

