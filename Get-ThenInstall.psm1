<#

    .SYNOPSIS
        This script will download and silently install anything from the internet

    .DESCRIPTION
        The script's only issue currently is that it does not perform cleanup, the installers are left after the install finishes 

    .PARAMETER DownloadLink [String]
        This is a string of the web URL of the installer

    .PARAMETER Destination
        This is the destination of the installer. If not specified it will be placed in C:\\installer\ which is created if non-existant

    .PARAMETER AppName
        The script will name the installer file <$AppName>.msi
        This must be One word and contain no letters or symbols to avoid unnecessary conflicts

    .EXAMPLE
        Download-And-Install -DownloadLink "https://chrome/download/chromeInstaller.exe" -Destination "C:\\Users\Babeeb\Desktop\Installer.exe" -AppName "Chrome"
        This would download the chrome installer to the desktop and run it. That chrome link is not real don't try to use it.

    .NOTES
        * Original Author         : Benjamin Longobardi - Benjamin.longobardi@gmail.com
        * Module Version Number   : 0.1
        * Date of Creation        : 1/4/2019
        * Date of Latest Update   : 1/4/2019
        * Latest Author           : Benjamin Longobardi
        * Latest Build Version    : ...
        * Comments                : I took the outline of this script from https://forum.pulseway.com/topic/1931-install-google-chrome-with-powershell/
        * Original Build Version  : 1.0, PSVersion ...
        * Build Version Details   :  


    .LINK
        https://github.com/benjaminlongobardi


#>

##End Help Section##

#region -- function
Function Get-ThenInstall
{
    [CmdletBinding `
    (
        ConfirmImpact='None',#(high,medium,low,none)
        SupportsShouldProcess=$true,
        HelpUri = ''
    )]

    Param
    (

        [Parameter(Mandatory=$true,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$false,
                    Position=0)]
        [string] $DownloadLink,

        [Parameter(Mandatory=$true,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$false,
                    Position=0)]
        [string] $AppName,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$false,
                    Position=0)]
        [string] $InstallerDestination
    )

    #region -- Main Script Functionality


        
        # The script silently installs chrome, however we can use it to silently install anything
        
        write-host "printing installer destination"
        write-host $InstallerDestination

        # Path for the workdir
        if($InstallerDestination -eq ""){
            $workdir = "c:\installer\"
        }
        else{
            $workdir = $InstallerDestination
        }
        # Check if work directory exists if not create it

        If (Test-Path -Path $workdir -PathType Container)
        { Write-Host "$workdir already exists" -ForegroundColor Red}
        ELSE
        { New-Item -Path $workdir  -ItemType directory }

        # Is it an EXE or an MSI installer

        $FileType = $DownloadLink.Remove(0, ($DownloadLink.Length -3))

        # Download the installer

        $source = $DownloadLink
        $destination = "$workdir\$AppName.$FileType"
        Invoke-WebRequest $source -OutFile $destination
        
        # Start the installation

        if($FileType -like "msi"){
            msiexec.exe /i "$workdir\$AppName.msi" /q /norestart 
        }
        elseif($FileType -like "exe"){
            $RunCommand = "$workdir$AppName.exe"
            Invoke-Expression $RunCommand
        }

        # Wait XX Seconds for the installation to finish

        #Start-Sleep -s 60

        # Remove the installer

        #rm -Force $workdir\chrome*


    #endregion Main Script Functionality 
    
}
#endregion function​