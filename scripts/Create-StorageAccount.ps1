# Set the variables
$resourceGroupName = "rg-friday-weu"
$location = "westeurope"
$storageAccountSuffix = "stfriday"
$random = (Get-Random -Minimum 0 -Maximum 99999).ToString('000000')
$storageAccountName = $storageAccountSuffix + $random

# Create the resource group.
New-AzResourceGroup -Name $resourceGroupName `
    -Location $location

# Create the storage account.
New-AzStorageAccount -ResourceGroupName $resourceGroupName `
    -Name $storageAccountName `
    -Location $location `
    -SkuName "Standard_RAGRS" `
    -Kind "StorageV2" `
    -AllowBlobPublicAccess $true

# Create the container.
$context = New-AzStorageContext -StorageAccountName $storageAccountName -UseConnectedAccount
New-AzStorageContainer -Name tfstate -Context $context

# Write the output.
$output = "The storage account " + $storageAccountName + " has been created."
Write-Output $output