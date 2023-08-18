# Learning Friday: Getting started with AKS

## Documentation

- [Introduction to Azure Kubernetes Service - Azure Kubernetes Service](https://learn.microsoft.com/en-us/azure/aks/intro-kubernetes)
- [Concepts - Kubernetes basics for Azure Kubernetes Services \(AKS\) - Azure Kubernetes Service](https://learn.microsoft.com/en-us/azure/aks/concepts-clusters-workloads)
- [Azure Well-Architected Framework review for Azure Kubernetes Service \(AKS\)](https://learn.microsoft.com/en-us/azure/well-architected/services/compute/azure-kubernetes-service/azure-kubernetes-service)
- [Everything you want to know about ephemeral OS disks and Azure Kubernetes Service \(AKS\)](https://techcommunity.microsoft.com/t5/fasttrack-for-azure/everything-you-want-to-know-about-ephemeral-os-disks-and-azure/ba-p/3565605#M205)
- [Introducing the Azure Linux container host for AKS](https://techcommunity.microsoft.com/t5/linux-and-open-source-blog/introducing-the-azure-linux-container-host-for-aks/ba-p/3824101)

## Deploying the resources

Connect to Azure and set the context.

```powershell
Connect-AzAccount
Set-AzContext <subscriptionId>
```

Create the storage account for the Terraform state.

```powershell
./scripts/Create-StorageAccount.ps1
```

Modify the Terraform backend configuration to use the storage account.

Deploy the resources.

```bash
cd terraform
terraform apply
```

Destroy the resources when finished to minimize the expenses.

```bash
terraform destroy
```
