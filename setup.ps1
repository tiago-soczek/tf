az account list

$subscriptionId = 'XXX'

az account set --subscription=$subscriptionId
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/$subscriptionId"

$env:ARM_SUBSCRIPTION_ID=$subscriptionId 
$env:ARM_CLIENT_ID='XXX'
$env:ARM_CLIENT_SECRET='XXX'
$env:ARM_TENANT_ID='XXX'
$env:ARM_ENVIRONMENT='public'

terraform init