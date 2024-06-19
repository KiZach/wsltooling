#!/bin/bash

echo -e "\n\nListing software versions:"

echo -e "\nAZCli:"
az --version

echo -e "\nDocker:"
docker --version
docker compose version

echo -e "\nTerraform:"
terraform --version

echo -e "\nApps:"
git --version
pwsh --version

