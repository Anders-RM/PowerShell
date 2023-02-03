#Winget install
Start-BitsTransfer -Source https://github.com/microsoft/winget-cli/releases/download/v1.4.10173/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -Destination "$PSScriptRoot/DesktopAppInstaller.msixbundle"
Start-BitsTransfer -Source https://kbhost.nl/wp-content/uploads/2022/04/Microsoft.VCLibs.140.00.UWPDesktop_14.0.30704.0_x64__8wekyb3d8bbwe.Appx.zip -Destination "$PSScriptRoot/VCLibs.Appx.zip"
Expand-Archive "$PSScriptRoot/VCLibs.Appx.zip" $PSScriptRoot 
Add-AppxPackage -Path "$PSScriptRoot/Microsoft.VCLibs.140.00.UWPDesktop_14.0.30704.0_x64__8wekyb3d8bbwe.Appx"
Add-AppPackage -Path "$PSScriptRoot/DesktopAppInstaller.msixbundle"
#Font for oh my posh
Start-BitsTransfer -Source https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Meslo.zip -Destination "$PSScriptRoot/Meslo.zip"
Expand-Archive "$PSScriptRoot/Meslo.zip" $PSScriptRoot
##dons not worke
Write-Output "Install fonts"
$fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)
foreach ($file in gci *.ttf)
{
    $fileName = $file.Name
    if (-not(Test-Path -Path "C:\Windows\fonts\$fileName" )) {
        echo $fileName
        dir $file | %{ $fonts.CopyHere($_.fullname) }
    }
}
cp *.ttf c:\windows\fonts\

winget update Microsoft.WindowsTerminal --accept-package-agreements --accept-source-agreements
winget install --id=Mozilla.Firefox.ESR  -e -h --accept-package-agreements --accept-source-agreements
winget install --id=Microsoft.VisualStudioCode  -e -h --accept-package-agreements --accept-source-agreements
winget install --id=Git.Git  -e -h --accept-package-agreements --accept-source-agreements
winget install --id=7zip.7zip  -e -h --accept-package-agreements --accept-source-agreements
winget install --id=JanDeDobbeleer.OhMyPosh  -e -h --accept-package-agreements --accept-source-agreements

New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarAl -Value 0 -PropertyType DWORD -Force
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0 -Force

stop-process -name explorer -force

Move-Item $PSScriptRoot\Microsoft.PowerShell_profile.ps1 $ENV:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 


Move-Item $PSScriptRoot\settings.json $ENV:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json


Read-Host -Prompt "Press any key to continue..."