#Winget install
Start-BitsTransfer -Source https://github.com/microsoft/winget-cli/releases/download/v1.4.10173/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -Destination "$PSScriptRoot/DesktopAppInstaller.msixbundle"
Start-BitsTransfer -Source https://kbhost.nl/wp-content/uploads/2022/04/Microsoft.VCLibs.140.00.UWPDesktop_14.0.30704.0_x64__8wekyb3d8bbwe.Appx.zip -Destination "$PSScriptRoot/VCLibs.Appx.zip"
Expand-Archive "$PSScriptRoot/VCLibs.Appx.zip" $PSScriptRoot 
Add-AppxPackage -Path "$PSScriptRoot/Microsoft.VCLibs.140.00.UWPDesktop_14.0.30704.0_x64__8wekyb3d8bbwe.Appx"
Add-AppPackage -Path "$PSScriptRoot/DesktopAppInstaller.msixbundle"
#Font for oh my posh
Start-BitsTransfer -Source https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Meslo.zip -Destination "$PSScriptRoot/Meslo.zip"
Expand-Archive  -Path "$PSScriptRoot/Meslo.zip" -DestinationPath "$PSScriptRoot/Meslo"
Remove-Item -Path "$PSScriptRoot/Meslo/LICENSE.txt"
Remove-Item -Path "$PSScriptRoot/Meslo/readme.md"


$FONTS = 0x14
$Path = "$PSScriptRoot\Meslo"
$objShell = New-Object -ComObject Shell.Application
$objFolder = $objShell.Namespace($FONTS)
$Fontdir = dir $Path
foreach ($File in $Fontdir) {
    if (!($file.name -match "pfb$")) {
        $try = $true
        $installedFonts = @(Get-ChildItem c:\windows\fonts | Where-Object { $_.PSIsContainer -eq $false } | Select-Object basename)
        $name = $File.baseName

        foreach ($font in $installedFonts) {
            $font = $font -replace "_", ""
            $name = $name -replace "_", ""
            if ($font -match $name) {
                $try = $false
            }
        }
        if ($try) {
            $objFolder.CopyHere($File.fullname)
        }
    }
}

winget update --id=Microsoft.WindowsTerminal --accept-package-agreements --accept-source-agreements
winget install --id=Mozilla.Firefox.ESR  -e -h --accept-package-agreements --accept-source-agreements
winget install --id=Microsoft.VisualStudioCode  -e -h --accept-package-agreements --accept-source-agreements
winget install --id=Git.Git  -e -h --accept-package-agreements --accept-source-agreements
winget install --id=7zip.7zip  -e -h --accept-package-agreements --accept-source-agreements
winget install --id=JanDeDobbeleer.OhMyPosh  -e -h --accept-package-agreements --accept-source-agreements
winget upgrade --all

New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarAl -Value 0 -PropertyType DWORD -Force
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0 -Force
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name HideFileExt -Value 0 -Force
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1 -Force

stop-process -name explorer -force

ssh-keygen -q -t rsa -N '@Ndersraeder' -f ~/.ssh/id_rsa -C "andersrm1808@gmial.com" 

New-Item $ENV:USERPROFILE\Documents\WindowsPowerShell -ItemType Directory
Move-Item $PSScriptRoot\Microsoft.PowerShell_profile.ps1 $ENV:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 
Copy-Item $PSScriptRoot\settings.json $ENV:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json  -Force