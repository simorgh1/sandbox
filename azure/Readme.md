# Using Serverless Azure Container Instances

My Current setup is:

- Windows 10 Home Version 10.0.18363.693
- WSL Ubuntu 18.04
- VS Code 1.42.1
- PowerShell preview
- Azure Cli 2.1.0
- Azure PowerShell Module

## Installing azure cli in WSL

Azure cli is the command line tool for interacting with azure services, It needs to be installed, the required packages and the installation is in the following script:

```bash
user@host1: ./install-azure-cli.sh
```

## PowerShell

PowerShell for linux could be installed using either the stable version 6.2.4 or the preview version 7.0.0.-rd.3.1

```bash
user@host1: sudo apt-get update -y && sudo apt-get install -y powershell
```

or the preview version:

```bash
user@host1: sudo apt-get update -y && sudo apt-get install -y powershell-preview
```

## Installing Azure PowerShell in WSL

For installing Azure PowerShell, open pwsh and install the az Module:

```powershell
PS /home/user1> Install-Module -Name Az -AllowClobber -Scope CurrentUser
```

## Azure Authentication

Login to Azure from command line:

```powershell
PS /home/user1> az login
```

Connect Azure PowerShell

```powershell
PS /home/user1> Connect-AzAccount
```
