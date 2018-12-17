#region help
<#

    .SYNOPSIS
        This module is intended for creating new users during the collegiate cyber defense competition

    .DESCRIPTION
        This module will take a set of information and create a user account for it. The idea is to
        simply run New-ADUser, assume certain flags, and add optional flags to the user object after creation

    .PARAMETER
        Ok so I'm not sure how much extra nonsense we might need , but here is what I put functionality for
        - Varname                - Required? - VarType          - DefaultValue
        - $Credential            - yes       - [PSCredential]   - 
        - $Name                  - yes       - [String]         -
        - $Password              - no        - [String]         -
        - $Enabled               - no        - [Boolean]        - $true
        - $ChangePasswordAtLogon - no        - [String]         -
        - $LogonWorkStations     - no        - [string]         -
        - $City                  - no        - [string]         -
        - $Company               - no        - [string]         -
        - $Country               - no        - [string]         -
        - $Department            - no        - [string]         -
        - $Description           - no        - [string]         -
        - $DisplayName           - no        - [string]         -
        - $Division              - no        - [string]         -
        - $EmailAddress          - no        - [string]         -
        - $EmployeeID            - no        - [string]         -
        - $EmployeeNumber        - no        - [string]         -
        - $OtherName             - no        - [string]         -
        - $Fax                   - no        - [string]         -
        - $GivenName             - no        - [string]         -
        - $HomePage              - no        - [string]         -
        - $HomePhone             - no        - [string]         -
        - $Initials              - no        - [string]         -
        - $Manager               - no        - [string]         -
        - $MobilePhone           - no        - [string]         -
        - $OfficePhone           - no        - [string]         -
        - $Organization          - no        - [string]         -
        - $OtherAttributes       - no        - [hashtable]      -
        - $POBox                 - no        - [string]         -
        - $PostalCode            - no        - [string]         -
        - $State                 - no        - [string]         -
        - $StreetAddress         - no        - [string]         -
        - $SurName               - no        - [string]         -
        - $Title                 - no        - [string]         -

    .NOTES
        Original Author:        Benjamin Longobardi
        Module Version Number:  1.0
        Date of Creation:       12/16/2018
        Last Updated On:        12/../2018
        Latest Author:          Benjamin Longobardi Benjamin.longobardi@gmail.com
        Latest Build Version:   
        Comments:               The general structure of this module is inspired by PSmodules written by Mike O'Rourke github.com/morourke3
        Original Build Version: 1.0, PSVersion 5.1.17134.1

    .LINK
        github.com/benjaminlongobardi
        
#>

## End Help Section ##

#endregion help

#region function
Function New-ADUser-Ccdc{

    [CmdletBinding `
    (
        ConfirmImpact='None',#(High, Medium, Low, None)
        SupportsShouldProcess=$true, 
        HelpUri = ''
    )]
    #region Param
    Param
    (
        [Parameter(
            Mandatory=$true,
            ValueFromPipeline=$false,
            ValueFromPipelineByPropertyName=$true,
            Position=0)]
        [PSCredential] $Credential,

        [Parameter(Mandatory=$true,
            ValueFromPipeline=$false,
            ValueFromPipelineByPropertyName=$true,
            Position=0)]
        [string] $Name,

        #region OptionalParams

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $Password,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
                    [ValidateSet($true, $false)]
        [boolean] $Enabled=$true,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
                    [ValidateSet($true, $false)]
        [boolean] $ChangePasswordAtLogon,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $LogonWorkStations,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $City,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $Company,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $Country,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $Department,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $Description,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $DisplayName,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $Division,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $EmailAddress,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $EmployeeID,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $EmployeeNumber,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $Fax,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $GivenName,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $HomePage,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $HomePhone,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $Initials,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $Manager,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $MobilePhone,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $Office,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $OfficePhone,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $Organization,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [hashtable] $OtherAttributes,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $OtherName,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $POBox,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $PostalCode,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $State,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $StreetAddress,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $Surname,

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [string] $Title

        #endregion OptionalParams

    )
    #endregion Param

    #region check Name Length
    
    if ($Name.Length -gt 20){
        Write-Host $("`n$Name is longer than 20 characters, please try again") -ForegroundColor Red -BackgroundColor Black
        Write-Host
        break;
    }
    #endregion check Name Length

    #region Generate Password

    #If we supplied passwords, use those... INSECURE / CHANGE IMMEDIATELY
    if($Password){
        $SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force
    }
    else{ #No password supplied
        [Reflection.Assembly]::LoadWithPartialName("System.Web")
        
        $UnsecurePassword = [System.Web.Security.Membership]::GeneratePassword(10,0)

        $SecurePassword = ($UnsecurePassword | ConvertTo-SecureString -AsPlainText -Force)
    }

    #endregion Generate Password





}
#endregion function