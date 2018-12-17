#region help
<#

    .SYNOPSIS
        This module is intended for creating new users during the collegiate cyber defense competition

    .DESCRIPTION
        This module will take a set of information and create a user account for it. The idea is to
        simply run New-ADUser, but to assume certain flags.

    .PARAMETER
        Ok so I'm not sure how much extra nonsense we might need 

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
        [string] $Enabled="$true",

        [Parameter(Mandatory=$false,
                    ValueFromPipeline=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
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



    #endregion Generate Password



}
#endregion function