#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

sudo apt update
sudo apt install -y wget apt-transport-https software-properties-common

source /etc/os-release

wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb

sudo dpkg -i packages-microsoft-prod.deb

rm packages-microsoft-prod.deb

sudo apt update

sudo apt install -y powershell

# Powershell modules that should be installed
pwsh -Command Install-Module -Name Az -Repository PSGallery -Force
