<#

    .SYNOPSIS
        This script will go through the windows server machines and change all necessary options to be 
        compliant with Windows Server 2012/2012 R2 Domain Controller Security Technical Implementation Guide

    .DESCRIPTION
        The script will output a report with what it has changed, and what still needs to be gone over
        manually

    .EXAMPLE
        Script-Name 

        Script: *runs*

        Output: *Saved*

#>

#region -- Variable declarations

$CurrentPCInfo = Get-WmiObject -Class win32_computersystem
$CurrentOSInfo = Get-WmiObject -Class Win32_OperatingSystem
$CurrentPCFQDN = $CurrentPC.Name + "." + $CurrentPC.Domain

#endregion Variable declarations


#region -- Step Through SCAP document and Script everything

    #Create the HTML File
    $html =  "<!DOCTYPE html>"
    $html += "<html>"
    $html += "<head>"
    $html += "<title>Windows Server Security Compliance Report</title>"
    $html += "</head>"
    $html += "<body>"

    $html += "<h1>Report for " + $CurrentPCFQDN + "</h1>"

    #servicePack
    $html += "<h5>Current Service Pack Info</h5>"
    $CurrentPCServicePack = $CurrentOSInfo.ServicePackMajorVersion.ToString() + "." + $CurrentOSInfo.ServicePackMinorVersion.ToString()
    $html += "<p>Service Pack: " + $CurrentPCServicePack + "</p>"
    $html += "<br>"

    #Drive information
    $html += "<h5>Current Drive Info</h5>"
    $CurrentPCDrives = Get-WmiObject -Class Win32_logicaldisk
    foreach ($drive in $CurrentPCDrives) { 
        $driveNumber = $drive.DeviceID
        $driveType = $drive.FileSystem
        $html += "<p>Drive: " + $driveNumber + "</p>"
        $html += "<p>FileSystem: " + $driveType + "</p>"
        $html += "<br>"
    }

    #Anonymous Enumeration of shares
    #
    #
    #

    #



    #end the Html hile
    $html += "</body>"
    $html += "</html>"

    #push html to current folder
    $html > ".\$CurrentPCFQDN.html"

#endregion Step Through SCAP document and Script everything