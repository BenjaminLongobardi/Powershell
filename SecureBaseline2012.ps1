<#

    .TODO
        This is a list of things I left off on so I dont forget to go back and do them
        1. Find the SID for act as a part of the OS so I can use it in that section
        2. Create a GPO that does everything right and import it.


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

#region -- Dot Source Required Modules

. .\ScriptsIFoundOnline\UserRights.psm1

#endregion

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
        
        $AnonEnumOfShares = ls -Path HKLM:\SYSTEM\CurrentControlSet\Control\Lsa | Select-Object Name,Property | Where-Object -Property Name -Like *RestrictAnonymous
        $html += "<h5>Anonymous Enumeration of Shares</h5><p>This should be defined and set to not allowed</p>"
        if($AnonEnumOfShares -eq ""){
            #if nothing is set here set it
            New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "RestrictAnonymous" -Value "Enabled"  -PropertyType "String"
        }
        elseIf($AnonEnumOfShares.Property -like "*Disabled*"){
            Set-Itemproperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa' -Name 'RestrictAnonymous' -value 'Enabled'
        }


    #endregion

    #region -- The act as part of the operating system user right must not be assigned to any groups or accounts
    #users with this right can masquerade as othr users and gain full access to a system

        #UserRights module - Group policy
        #Navigate to Local Computer Policy >> Computer Configuration >> Windows Settings >> Security Settings >> Local Policies >> User Rights Assignment.
        #this policy should be defined with no accounts assigned to it

        $ActAsOSAccounts = Get-AccountsWithUserRight -Right SeTcbPrivilege

        foreach($account in $ActAsOSAccounts){
            Revoke-UserRight -Account $account -Right SeTcbPrivilege
        }

        $html += "<h5>Act as a part of the OS user right</h5><p>Note: the affected accounts are shown and must relog</p>"
        $html += "<ul>"
        foreach($account in $ActAsOSAccounts){
            $html += "<li>" + $account.Name + "</li>"
        }
        $html += "</ul>"


    #endregion

    #region -- Anonymous Access to registry must be restricted
    #Some processes need this. others do not. Print this into the report to handle it manually from there

        # this key should exist wih these values

        # HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\SecurePipeServers\Winreg\ 
        # Administrators - Full 
        # Backup Operators - Read(QENR)
        # Local Service - Read
    
    #endregion

    #region -- The LanMan authentication level must be set to ntlmv2 response only, and refuse LM and NTLM
    #LM and NTLM should only be allowed for backwards compatability purposes. They are not secure and those components forcing this compatability requirement should be reworked
        
        # Analyze the system using the Security Configuration and Analysis snap-in. 
        # Expand the Security Configuration and Analysis tree view. 
        # Navigate to Local Policies -> Security Options. 
        # If the value for "Network security: LAN Manager authentication level" is not set to "Send NTLMv2 response only. Refuse LM & NTLM" (Level 5), this is a finding.

        #The policy referenced configures the following registry value:
        # HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa\
        # Value Name: LmCompatibilityLevel

    #endregion

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