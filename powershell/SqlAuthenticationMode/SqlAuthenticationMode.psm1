<#
    SqlAuthenticationMode PowerShell module
    
    Provides methods for SqlAuthenticationMode
#>

#Requires -Version 4
#Requires -RunAsAdministrator
#Requires -Modules SqlServer

<#
.SYNOPSIS

The default SqlAuthenticationMode can be set to the Mixed mode, so that sql server authentication can be used.

.DESCRIPTION

Sets the current sql authentication mode to mixed. Windows sql service is restarted afterwards.

.PARAMETER SqlInstance
The name of the MSSQL instance.

.PARAMETER MSSQLService
The name of the MSSQL windows service

#>
function Set-SqlMixedAuthenticationMode
{
    param(   
        [Parameter(Mandatory=$true, Position=0)]
        [string]$SqlInstance,
        [Parameter(Mandatory=$true, Position=1)]
        [string]$MSSQLService
    )
    process {

        $Instance = Get-SqlInstance -ServerInstance $SqlInstance -ErrorAction SilentlyContinue

        if($Instance)
        {
            if($Instance.Settings.LoginMode -eq "Mixed")
            {
                Write-Host "SqlAuthenticationMode already set."
                return;
            }

            $Instance.Settings.LoginMode = "Mixed"
            $Instance.Alter()

            Restart-Service $MSSQLService | Out-Null

        }
        else {
            Write-Host "Could not connect to SqlInstance $($SqlInstance)"
        }
    }
}

<#
.SYNOPSIS

Returns the current SqlAuthenticationMode.

.DESCRIPTION

Gets the current sql authentication mode.

.PARAMETER SqlInstance
The name of the MSSQL instance.

#>
function Get-SqlAuthenticationMode
{
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$SqlInstance
    )
    process {

        $Instance = Get-SqlInstance -ServerInstance $SqlInstance -ErrorAction SilentlyContinue

        if($Instance)
        {
            Write-Host "SqlAuthenticationMode is: $($Instance.Settings.LoginMode)"
        }
        else {
            Write-Host "Could not connect to SqlInstance $($SqlInstance)"
        }
    }
}
