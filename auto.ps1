Invoke-WebRequest -uri https://github.com/microsoft/winget-cli/releases/download/v1.4.10173/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -OutFile "$PSScriptRoot/winget.msixbundle"
add-appxpackage -Path "$PSScriptRoot/winget.msixbundle"
Read-Host -Prompt "Press any key to continue..."