Invoke-WebRequest -Uri https://github.com/microsoft/winget-cli/releases/download/v1.4.10173/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -OutFile "$PSScriptRoot/DesktopAppInstaller.msixbundle" -UseBasicParsing 
Invoke-WebRequest -Uri https://kbhost.nl/wp-content/uploads/2022/04/Microsoft.VCLibs.140.00.UWPDesktop_14.0.30704.0_x64__8wekyb3d8bbwe.Appx.zip -OutFile "$PSScriptRoot/VCLibs.Appx.zip" -UseBasicParsing 
Expand-Archive C:\Microsoft.VCLibs.140.00.UWPDesktop_14.0.30704.0_x64__8wekyb3d8bbwe.Appx.zip C:\
Add-AppxPackage -Path "C:\Microsoft.VCLibs.140.00.UWPDesktop_14.0.30704.0_x64__8wekyb3d8bbwe.Appx"
Add-AppPackage -Path "C:\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"


















Read-Host -Prompt "Press any key to continue..."