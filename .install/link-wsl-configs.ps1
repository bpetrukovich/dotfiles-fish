#requires -runasadministrator

# NOTE: This script is intended to be run from the Windows host.
#       It will create symlinks in the Windows user's home directory
#       pointing to the AWS and Kubernetes configuration directories in WSL.

# Prompt for WSL distribution name
do {
    $wslDistro = Read-Host "Enter WSL distribution name"
    if ([string]::IsNullOrWhiteSpace($wslDistro)) {
        Write-Host "Distribution name cannot be empty. Please try again." -ForegroundColor Red
    }
} while ([string]::IsNullOrWhiteSpace($wslDistro))

# Prompt for WSL username
do {
    $wslUser = Read-Host "Enter WSL linux username"
    if ([string]::IsNullOrWhiteSpace($wslUser)) {
        Write-Host "Username cannot be empty. Please try again." -ForegroundColor Red
    }
} while ([string]::IsNullOrWhiteSpace($wslUser))

$wsl = "\\wsl.localhost\$wslDistro\home\$wslUser"
$home = $env:USERPROFILE

Remove-Item "$home\.aws"  -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$home\.kube" -Recurse -Force -ErrorAction SilentlyContinue

cmd /c mklink /D "$home\.aws"  "$wsl\.aws"
cmd /c mklink /D "$home\.kube" "$wsl\.kube"

Pause
