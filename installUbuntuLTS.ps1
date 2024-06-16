Param (
[Parameter(Mandatory=$True)][ValidateNotNull()][string]$wslName,
[Parameter(Mandatory=$True)][ValidateNotNull()][string]$wslInstallationPath,
[Parameter(Mandatory=$True)][ValidateNotNull()][string]$username,
[Parameter(Mandatory=$True)][ValidateNotNull()][string]$installAllSoftware
)

# create staging directory and download distro if it does not exists
if (-Not (Test-Path -Path .\staging)) { $dir = mkdir .\staging }

if (-Not (Test-Path -Path .\staging\ubuntuLTS.appx)) { 
    curl.exe -L -o .\staging\ubuntuLTS.appx https://aka.ms/wslubuntu2004arm
    Copy-Item .\staging\ubuntuLTS.appx -Destination .\staging\$wslName.zip
}

Expand-Archive .\staging\$wslName.zip .\staging\$wslName

# Create distro path if not exists
if (-Not (Test-Path -Path $wslInstallationPath)) {
    mkdir $wslInstallationPath
}

# Remove distro is exists
if ((Get-ChildItem -Path $wslInstallationPath\*.vhdx -force | Measure-Object).Count -ne 0) {
    $null = wsl --unregister $wslName
}

# Import new distro
wsl --import $wslName $wslInstallationPath .\staging\$wslName\install.tar.gz

# Clean up
Remove-Item -r .\staging\$wslName\

# Update the system
wsl -d $wslName -u root bash -ic "apt update; apt upgrade -y"

# Create your user and add it to sudoers
wsl -d $wslName -u root bash -ic "./scripts/config/system/createUser.sh $username ubuntu"

# Ensure WSL Distro is restarted when first used with user account
wsl -t $wslName

# Install software if selected
if ($installAllSoftware -ieq $true) {
    wsl -d $wslName -u root bash -ic "./scripts/config/system/sudoNoPasswd.sh $username"
    wsl -d $wslName -u root bash -ic ./scripts/install/installBasePackages.sh
    wsl -d $wslName -u $username bash -ic ./scripts/install/installAllSoftware.sh
    wsl -d $wslName -u root bash -ic "./scripts/config/system/sudoWithPasswd.sh $username"
}
