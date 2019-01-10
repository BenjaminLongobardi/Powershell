<#

    .SYNOPSIS
        

    .DESCRIPTION
        This script will do the following 

    .PARAMETER NewAdminName 


    .EXAMPLE
        

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
Function Function-Name
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
        [string] $NewAdminName
    )

    #region -- Main Script Functionality

        


    #endregion Main Script Functionality 
    
}
#endregion function​