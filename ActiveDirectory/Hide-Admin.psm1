<#

    .SYNOPSIS
        This script is the Admin honeypot script. It hides the real admin and replaces it with a fake one. Any attempts
        to login to this account are obvious attempts at a breach and immediate action should be taken.

    .DESCRIPTION
        This script will do the following 
            1: Rename the current computer's administrator account to something other than administrator.
            2: Create a new user and make that user named Administrator with matching description
            3: Disable the current computer's admin account if allowed
            
        *I would like to do the following but not sure if I should here.
            1: Set up logging and alerts for the new honeypot admin
            2: Also setup logging and alerts for actual admin

    .PARAMETER NewAdminName 
        (string) This will be what the Administrator is renamed to
        REQUIRED

    .PARAMETER DisableBuiltinAdmin
        (boolean) This will determine whether the builtin admin account will be disabled
        REQUIRED
        ***Warning***   DO NOT SET THIS TO TRUE UNLESS ANOTHER ADMIN EXISTS OR YOU WILL HAVE NO ADMIN

    .EXAMPLE
        New-Fakemin -NewAdminName "Babeeb" -DisableBuiltinAdmin $true

        This renames the current builtin admin account to Babeeb and disables it. Then it creates a new account 
        called Administrator which has no permissions

    .NOTES
        * Original Author         : Benjamin Longobardi - Benjamin.longobardi@gmail.com
        * Module Version Number   : 0.1
        * Date of Creation        : 1/4/2019
        * Date of Latest Update   : 1/4/2019
        * Latest Author           : Benjamin Longobardi
        * Latest Build Version    : ...
        * Comments                : General formatting for this script is taken from https://github.com/morourke3
        * Original Build Version  : 1.0, PSVersion ...
        * Build Version Details   :  


    .LINK
        https://github.com/benjaminlongobardi


#>

##End Help Section##

#region -- function
Function New-Fakemin
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
        [string] $NewAdminName,

        [Parameter(Mandatory=$true,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$false,
                    Position=0)]
        [boolean] $DisableBuiltinAdmin
    )

    #region -- Main Script Functionality


        # Rename the local Administrator
        Get-LocalUser | Where-Object -Property "SID" -Like "*-500" | Rename-LocalUser -NewName $NewAdminName 
        $WriteHost = Write-Host $("`nLocal Admin renamed to $NewAdminName") -ForegroundColor Green -BackgroundColor Black
        $WriteHost

        #region -- Create new User and clone administrator properties

            New-LocalUser -Name "Administrator" -Password (Read-Host -AsSecureString -Prompt "Enter New Password") `
            -Description "Built-in account for administering the computer/domain" 
            $WriteHost = Write-Host $("`nDummy Admin created") -ForegroundColor Blue -BackgroundColor Black
            $WriteHost

        #endregion Create new User and clone administrator properties

        #region -- Disable the local builtin admin if true
        
            if($DisableBuiltinAdmin -eq $true){
                Get-LocalUser | Where-Object -Property "SID" -Like "*-500" | Disable-LocalUser
                $WriteHost = Write-Host $("`nLocal Admin Disabled") -ForegroundColor Yellow -BackgroundColor Black
                $WriteHost
            }
            else{
                $WriteHost = Write-Host $("`nLocal Admin Not Disabled") -ForegroundColor Red -BackgroundColor Black
                $WriteHost
            }

        #endregion Disable the local builtin admin if true


    #endregion Main Script Functionality 
    
}
#endregion function​