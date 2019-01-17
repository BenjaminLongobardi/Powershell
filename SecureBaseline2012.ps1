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


#region -- Step Through SCAP document and Script everything. 
#an HTML output report will be generated. it will be ugly. I am not the HTML guy.

    #Create the HTML File
    $html =  "<!DOCTYPE html>"
    $html += "<html>"
    $html += "<head>"
    $html += "<title>Windows Server Security Compliance Report</title>"
    $html += "</head>"
    $html += "<body>"

    $html += "<h1>Report for " + $CurrentPCFQDN + "</h1>"

    #region -- Systems must be maintained at a supported service pack level

        #servicePack
        $html += "<h5>Current Service Pack Info</h5>"
        $CurrentPCServicePack = $CurrentOSInfo.ServicePackMajorVersion.ToString() + "." + $CurrentOSInfo.ServicePackMinorVersion.ToString()
        $html += "<p>Service Pack: " + $CurrentPCServicePack + "</p>"
        $html += "<br>"

    #endregion

    #region -- local volumes must use a format that supports NTFS drive attributes

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

    #endregion

    #region -- Anonymous Enumeration of shares must be restricted
    #Null sessions should not have this right, as anonymous users can map a network and search for attack vectors
        
        

    #endregion

    #The act as part of the operating system user right must not be assigned to any groups or accounts
    #
    #
    #

    #Anonymous Access to registry must be restricted
    #
    #
    #

    #The LanMan authentication level must be set to ntlmv2 response only, and refuse LM and NTLM
    #
    #
    #

    #Reversible password encryption must be disabled
    #
    #
    #

    #Autoplay must be disabled for all drives
    #
    #
    #

    #Named pipes that can be accessed anonympusly...    ******************Confusing, not sure if needed***************

    #Unauthorized remotely accessible registry paths must not be configured
    #
    #
    #

    #NetShares that can be accessed anonymously cannot be allowed
    #
    #
    #

    #Solicited remote assistance must not be allowed
    #
    #
    #

    #local accounts with blank passwords must be disabled  * FINALLY ONE I DONT HAVE TO GOOGLE *
    #
    #
    #

    #Prevent the storage of the LAN manager hash of passwords
    #
    #
    #

    #unauthorized remotely accessible registry paths and sub-paths should not be configured
    #
    #
    #

    #Anonymous access to Named Pips and Shares must be restricted
    #
    #
    #

    #Active Directory Data files must habe proper access control Permissions
    #
    #
    #

    #the debug programs user right must only be assigned to the administrators group
    #
    #
    #

    #Autoplay must be turned off for non-volume devices
    #
    #
    #

    #default autorun behavior must be configured to prevent autorun commands
    #
    #
    #

    #Standard user accounts must only have read permissions to the winlogon registry key
    #
    #
    #

    #Anonymous enumeration of SAM accounts must not be allowed
    #
    #
    #

    #The create a token object user right must not be assigned to any groups or accounts
    #
    #
    #

    #Standard user accounts must only have read permissions to the active setup / installed components registry key
    #
    #
    #

    #Windows installer always install with elevated privileges option must be disabled
    #
    #
    #

    #The WinRM client must not use basic authentication
    #
    #
    #

    #The WinRM service must not use basic authentication
    #
    #
    #







    #end the Html hile
    $html += "</body>"
    $html += "</html>"

    #push html to current folder
    $html > ".\$CurrentPCFQDN.html"

#endregion Step Through SCAP document and Script everything