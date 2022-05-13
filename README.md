# Terraform OpenID Connect to Azure

Repository for starting out with Terraform to Azure with OpenID Connect authentication

## Prereqs OIDC

- Create an Azure AD App Registration.
- Add federated credentials for the Azure Active Directory application.
- Create GitHub secrets for storing Azure configuration.

### Create Azure AD App Registration

```pwsh
az ad app create --display-name myApp
az ad sp create --id <appId>
az role assignment create --role contributor --subscription $subscriptionId --assignee-object-id  $assigneeObjectId --assignee-principal-type ServicePrincipal --scope /subscriptions/$subscriptionId/resourceGroups/$resourceGroupName
```

Note the appId as this is your `Client Id` for workflow use later.

### Add federated credentials

Follow [this guide](https://docs.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-portal%2Cwindows#add-federated-credentials) from Microsoft for updated guidance.

### Create GitHub secrets

AAD_APP_ID – Will be the service principal ID from above
AAD_TENANT_ID – The Azure AD tenant ID (Directory ID) to where the service principal was created
AZURE_SUBSCRIPTION_ID – Subscription ID of where you want to deploy Terraform resources

## Prereqs Terraform

- Create Resource Group
- Create Storage Account
- Create Storage Account Container

```shell
az group create -n resourcegroupname -l westeurope
az storage account create -n myownstorageaccount123 -g resourcegroupname -l westeurope --sku Standard_LRS
az storage container create -n terraformstate
```

