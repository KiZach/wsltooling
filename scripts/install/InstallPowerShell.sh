#!/bin/bash

set -euo pipefail
DIR_ME=$(realpath $(dirname $0))

sudo apt update
sudo apt install -y curl tar

curl -L -o /tmp/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v7.3.12/powershell-7.3.12-linux-arm64.tar.gz

sudo mkdir -p /opt/microsoft/powershell/7

sudo tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7

sudo chmod +x /opt/microsoft/powershell/7/pwsh

sudo ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh

# Powershell modules that should be installed
pwsh -Command Install-Module -Name Az -Repository PSGallery -Force
