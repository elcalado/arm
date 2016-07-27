
Login-AzureRmAccount
#Select-AzureRmSubscription -SubscriptionId "ff0d44a7-e7f6-4a10-bfdf-3cbba8eddc36"
Select-AzureRmSubscription -SubscriptionId "c90faef9-fae5-4121-be15-834cee249d71"

# Sample 1- Hello World
New-AzureRmResourceGroup -Name "elcalado-hello" -Location "West Europe" -Force -Verbose
New-AzureRmResourceGroupDeployment -ResourceGroupName "elcalado-hello" -TemplateFile "C:\code\arm\helloWorld.json" -Verbose

#get info about the resource group
Get-AzureRmResourceGroup -Name "elcalado-hello"


# Sample 2 - Storage Account
New-AzureRmResourceGroup -Name "elcalado-store1" -Location "West Europe" -Force -Verbose
New-AzureRmResourceGroupDeployment -ResourceGroupName "elcalado-store1" -TemplateFile "C:\code\arm\storageaccount.json" -Verbose

# Sample 3 - Web + SQL Dev / Test
New-AzureRmResourceGroup -Name "elcalado-dev" -Location "West Europe" -Force -Verbose
New-AzureRmResourceGroupDeployment -ResourceGroupName "elcalado-dev" -TemplateFile "C:\code\arm\dev.json" -Verbose 

# Sample 4 - Tagging
$myTags = New-Object System.Collections.ArrayList
$myTags.Add(@{ Name="owner"; Value="calado"})
$myTags.Add(@{ Name="env"; Value="production"})

New-AzureRmResourceGroup -Name "elcalado-dev2" -Location "West Europe" -Tag $mytags -Force -Verbose 
New-AzureRmResourceGroupDeployment -ResourceGroupName "elcalado-dev2" -TemplateFile "C:\code\arm\dev.json" -Verbose

# Sample 5 - Inside Tagging
$myTags = New-Object System.Collections.ArrayList
$myTags.Add(@{ Name="owner"; Value="calado"})
$myTags.Add(@{ Name="env"; Value="production"})
New-AzureRmResourceGroup -Name "elcalado-dev3" -Location "West Europe" -Tag $mytags -Force -Verbose 
New-AzureRmResourceGroupDeployment -ResourceGroupName "elcalado-dev3" -TemplateFile "C:\code\arm\devtags.json" -Verbose

# Sample 6 - RBAC
New-AzureRmResourceGroup -Name "elcalado-rbac" -Location "North Europe" -Force -Verbose
New-AzureRmResourceGroupDeployment -ResourceGroupName "elcalado-rbac" -TemplateFile "C:\code\arm\storageaccount.json" -Verbose

# get role list
Get-AzureRmRoleDefinition | FT Name, Description

# get assignments for resource group
Get-AzureRmRoleAssignment -ResourceGroupName "elcalado-rbac"

# add a new user role assignment to a resource group
New-AzureRmRoleAssignment -SignInName joalmeid@microsoft.com -RoleDefinitionName "Contributor" -ResourceGroupName "elcalado-rbac"

# get role assignments for user
Get-AzureRmRoleAssignment -SignInName joalmeid@microsoft.com -ExpandPrincipalGroups

# remove role assignment for user
Remove-AzureRmRoleAssignment -ResourceGroupName "elcalado-rbac" -RoleDefinitionName "Contributor" -SignInName "joalmeid@microsoft.com" 

# get authorization audit log
Get-AzureRMAuthorizationChangeLog -StartTime ([DateTime]::Now - [TimeSpan]::FromDays(7)) | FT Caller,Action,RoleName,PrincipalType,PrincipalName,ScopeType,ScopeName

# Sample 8 - Logging 
Get-AzureRmResourceGroupDeployment -ResourceGroupName “elcalado-dev3" -DeploymentName "devtags"
Get-AzureRmResourceGroupDeploymentOperation -DeploymentName "devtags" -ResourceGroupName “elcalado-dev3" -Verbose

#Sample 78- Resource Locking
New-AzureRmResourceLock -LockLevel CanNotDelete -LockNotes 'No deleting!' -LockName 'elcaladolock' -ResourceGroup 'elcalado-rbac' -Verbose 
Remove-AzureRmResourceLock -LockName "elcaladolock" -ResourceGroupName "elcalado-rbac"

#Sample 9 - Resource Group Export
Export-AzureRmResourceGroup -ResourceGroupName "elcalado-dev3" -Path c:\code\arm\exports\dev3.json
Save-AzureRmResourceGroupDeploymentTemplate -DeploymentName devtags -ResourceGroupName elcalado-dev3 -Path c:\code\arm\exports\dev.json

# Sample 10 - TODO App
New-AzureRmResourceGroup -Name "elcalado-todo" -Location "North Europe" -Force -Verbose
New-AzureRmResourceGroupDeployment -ResourceGroupName "elcalado-todo" -TemplateUri "c:\code\arm\todo.json" -Verbose 
