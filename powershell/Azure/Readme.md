# AzureVM PowerShell module

Provides methods for managing Azure VMs using az cli 

## Requirements

All requirements already available in the provided devcontainer, open the folder in vscode.

### Getting started

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
