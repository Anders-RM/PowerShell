Invoke-WebRequest -uri https://github.com/microsoft/winget-cli/releases/download/v1.4.10173/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -OutFile "$PSScriptRoot/winget.msixbundle"
start-Process -Filepath "$PSScriptRoot/winget.msixbundle" -ArgumentList $args