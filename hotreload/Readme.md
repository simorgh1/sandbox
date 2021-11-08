### Using Serverless Azure Container Instances

My Current setup is:

- Macbook Air M1
- VS Code
- PowerShell preview
- Azure Cli beta
- Azure PowerShell Module

The first challenge was to build the devcontainer, since the current dotnet docker images for devcontainer are targeting amd64 platform. So I rebuilt the default Dockerfile with sdk:5.0 which has also arm64v8 platform, otherwise it would run very slow on m1 chip.

The next challenge was to run azure-cli, since again the default installation is for amd64, which will not run on m1 again, so I installed azure-cli beta, which is based on python3 and it works on m1 without errors, sofar ;-)

### Installing Azure PowerShell

For installing Azure PowerShell, open pwsh and install the az Module:

```powershell
PS /workspaces/sandbox/azure> Install-Module -Name Az -AllowClobber -Scope CurrentUser
```

### Azure Authentication

Login to Azure from command line:

```powershell
PS /workspaces/sandbox/azure> az login
```

After login, you could try to verify your connection by running some command like:

```powershell
PS /workspaces/sandbox/azure> az account list | jq .[0].user.name
```

which should return your loggedin user's email.

Or you could login using Azure PowerShell:

```powershell
PS /workspaces/sandbox/azure> Connect-AzAccount
```
