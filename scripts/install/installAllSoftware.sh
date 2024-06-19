#!/bin/bash

set -euo pipefail

DIR_ME=$(realpath $(dirname $0))
. ${DIR_ME}/.installUtils.sh
setUserName "$(whoami)"

bash ${DIR_ME}/../config/system/prepareXServer.sh ${USERNAME}

echo -e "\n\nInstalling Azure CLI"
bash ${DIR_ME}/installAzCli.sh

echo -e "\n\nInstalling PowerShell"
bash ${DIR_ME}/installPowerShell.sh

echo -e "\n\nInstalling Terraform"
bash ${DIR_ME}/installTerraform.sh

echo -e "\n\nInstalling docker & docker-compose apt"
bash ${DIR_ME}/installDocker.sh

# clean-up
sudo apt autoremove -y

bash ${DIR_ME}/../report/listVersions.sh
