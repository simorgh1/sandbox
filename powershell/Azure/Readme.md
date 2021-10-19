# AzureVM PowerShell module
Provides methods for managing Azure VMs using az cli 

## Requirements
Please first install [Azure cli for windows](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?view=azure-cli-latest)

Then login to your azure account
```
az login
```

## Import module

```
PS C:\Azure\ Import-module .\AzureVM.psm1
```

## Methods

### Help
```
PS C:\ Get-Help AzureVM
```

Then you could get the list of available VMs and their current status.

```
PS C:\ Get-AzureVMStatus
```