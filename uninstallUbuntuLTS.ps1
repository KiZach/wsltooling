Param (
[Parameter(Mandatory=$True)][ValidateNotNull()][string]$wslName
)

wsl --unregister $wslName