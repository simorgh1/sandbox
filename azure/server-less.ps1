
$locationName            = 'westeurope'              # An Azure region close to you, 'Get-AzLocation' to list them all
$resourceGroupName       = 'rgHelloWorldContainer'   # Resource group to contain this demo
$webAppName              = 'helloworld0303'          # Name for your web app
$containerRegistryName   = 'bahiregistry2020'        # GLOBALLY UNIQUE name for your container registry
$webAppDNSName           = 'serverlesshelloworld0303'# GLOBALLY UNIQUE dns name, will be prepended to .azurecontainer.io

# Create azure resource group for demo
if ((az group exists -n $resourceGroupName) -eq $false)
{
    Write-Output "Creating resource group: $resourceGroupName"
    az group create -n $resourceGroupName -l $locationName --tags demo
}

# check the availability for the acr name
if (((az acr check-name -n $containerRegistryName) | ConvertFrom-Json).nameAvailable -eq $true)
{
    Write-Host "Creating ACR $containerRegistryName"
    
    # Authenticate Azure PowerShell
    Connect-AzAccount

    # create acr from ms arm template in github
    $containerRegistryTemplateUrl = 'https://raw.githubusercontent.com/microsoft/devops-project-samples/master/dotnet/aspnetcore/kubernetes/ArmTemplates/containerRegistry-template.json'
    $containerRegistryParams = @{
        registryName        = $containerRegistryName
        registryLocation    = $locationName
    }

    New-AZResourceGroupDeployment -Name "$resourceGroupName-ACR-Deployment" -ResourceGroupName $resourceGroupName -TemplateUri $containerRegistryTemplateUrl -TemplateParameterObject $containerRegistryParams
}

# Get acr
$azureContainerRegistry = (az acr show -n $containerRegistryName ) | ConvertFrom-Json

Write-Host "Using ACR Name: $($azureContainerRegistry.Name)"

Set-Location ./helloworld

Write-Host "Creating docker image"

az acr build --registry $azureContainerRegistry.Name --image mywebapp:v1 .

[array]$repositories = az acr repository list --name $azureContainerRegistry.Name | ConvertFrom-Json
$repository = $repositories[0]

$imageTags = az acr repository show-tags --name $azureContainerRegistry.Name --repository $repository --detail --orderby time_desc | ConvertFrom-JSON
$imageTag = $imageTags[0]
$dockerImagePath = "$($azureContainerRegistry.LoginServer)/$($repository):$($imageTag.name)"

# getting credentials
$regCred = Get-AzContainerRegistryCredential -ResourceGroupName $resourceGroupName  -Name $azureContainerRegistry.Name
$PSCred = [PSCredential]::New($regCred.Username, (ConvertTo-SecureString $regCred.Password -AsPlainText -Force)) # Type accelerators rule!

# ContainerGroup Arguments
$ContainerGroupArguments = @{
    ResourceGroupName   = $resourceGroupName
    Name                = "$webAppName-cg"    #build container group name from the webapp name
    Image               = $dockerImagePath
    IpAddressType       = 'Public'
    DNSNameLabel        = $webAppDNSName
    Port                = 80                    #optional
    RegistryCredential  = $PSCred               #required if this is NOT a public docker registry
    IdentityType        = 'SystemAssigned'      #optional, but useful for a future tutorial
    Tag                 = $tags                 #optional uses hash table defined above
    Debug               = $true                 #optional but very interesting to see the debug output
    }

# Deploy container
Write-Host "Creating Azure Container Group"
$newACG = New-AzContainerGroup @ContainerGroupArguments

Write-Output " Paste $($newACG.FQDN)  into your favorite web browser"

# View log
Get-AzContainerInstanceLog  -ResourceGroupName $resourceGroupName -ContainerGroupName $ContainerGroupArguments.Name

# Cleanup
# Remove-AzResourceGroup -ResourceGroupName $resourceGroupName -Force