# Silent Install Chrome
# https://enterprise.google.com/chrome/chrome-browser/

# I took this script from https://forum.pulseway.com/topic/1931-install-google-chrome-with-powershell/
# The script silently installs chrome, however we can use it to silently install anything

# Path for the workdir
$workdir = "c:\installer\"

# Check if work directory exists if not create it

If (Test-Path -Path $workdir -PathType Container)
{ Write-Host "$workdir already exists" -ForegroundColor Red}
ELSE
{ New-Item -Path $workdir  -ItemType directory }

# Download the installer

$source = "https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B03FE9563-80F9-119F-DA3D-72FBBB94BC26%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dx64-stable/dl/chrome/install/googlechromestandaloneenterprise64.msi"
$destination = "$workdir\chrome.msi"
Invoke-WebRequest $source -OutFile $destination

# Start the installation

msiexec.exe /i "$workdir\chrome.msi" /q /norestart 

# Wait XX Seconds for the installation to finish

#Start-Sleep -s 60

# Remove the installer

#rm -Force $workdir\chrome*