#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

sudo apt update
sudo apt install -y wget unzip

wget https://releases.hashicorp.com/terraform/1.8.5/terraform_1.8.5_linux_$(dpkg --print-architecture).zip
unzip terraform_1.8.5_linux_$(dpkg --print-architecture).zip
sudo install terraform /usr/local/bin/

rm terraform_1.8.5_linux_$(dpkg --print-architecture).zip
rm LICENSE.txt
rm terraform
