#requires -runasadministrator

# NOTE: This script is intended to be run from the Windows host.
#       It will create symlinks in the Windows user's home directory
#       pointing to the AWS and Kubernetes configuration directories in WSL.

$wsl = "\\wsl.localhost\fish-wsl\home\bogdan"
$home = $env:USERPROFILE

Remove-Item "$home\.aws"  -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$home\.kube" -Recurse -Force -ErrorAction SilentlyContinue

cmd /c mklink /D "$home\.aws"  "$wsl\.aws"
cmd /c mklink /D "$home\.kube" "$wsl\.kube"

Pause
