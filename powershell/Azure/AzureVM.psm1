<#
    AzureVM PowerShell module
    
    Provides methods for managing Azure VMs using az cli 
#>

#Requires -Modules Az.Accounts

Function Start-AzureVM {
    Param(
        # VM Name
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Name
    )
    process {
       $vmRg = ((az vm list -d | ConvertFrom-Json) | where name -eq $Name).resourceGroup

        if($vmRg)
        {
            Write-Host "Starting Vm:$($Name) Rg:$($vmRg)"

            az vm start -n $Name -g $vmRg
            return
        }
        
        Write-Host "VM $($Name) not found" 
    }
}

Function Stop-AzureVM {
    Param(
        # VM Name
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Name
    )

    process {
        $vmRg = ((az vm list -d | ConvertFrom-Json) | where name -eq $Name).resourceGroup

        if($vmRg)
        {
            Write-Host "Stoping Vm:$($Name) Rg:$($vmRg)"

            az vm deallocate -n $Name -g $vmRg
            return
        }
        
        Write-Host "VM $($Name) not found"
    }
}

Function Connect-AzureVM {
    Param(
        # VM Name
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Name
    )

    process {
        $vmIp = ((az vm list -d | ConvertFrom-Json) | where name -eq $Name).publicIps

        if($vmIp)
        {
            Write-Host "Rdp Vm:$($Name) Ip:$($vmIp)"

            mstsc /v:"$($vmIp):3389" /multimon
            return
        }

        Write-Host "VM $($Name) not found"
    } 
}

Function Get-AzureVMStatus {
    process {
        az vm list -d -o table
    }
}