Get-AzureSubscription

Login-AzureRmAccount
Select-AzureRmSubscription -SubscriptionId "ff0d44a7-e7f6-4a10-bfdf-3cbba8eddc36"

# Sample 1- Hello World
New-AzureRmResourceGroup -Name "elcalado-hello" -Location "West Europe" -Force -Verbose
New-AzureRmResourceGroupDeployment -ResourceGroupName "elcalado-hello" -TemplateFile "C:\code\armwebcast\src\helloWorld.json" -Verbose

Get-AzureRmResourceGroup -Name "elcalado-hello"

# Sample 2 - Storage Account
New-AzureRmResourceGroup -Name "elcalado-store1" -Location "West Europe" -Force -Verbose
New-AzureRmResourceGroupDeployment -ResourceGroupName "elcalado-store1" -TemplateFile "C:\code\armwebcast\src\storageaccount.json" -Verbose

# Sample 3 - Web + SQL Dev / Test
New-AzureRmResourceGroup -Name "elcalado-dev" -Location "West Europe" -Force -Verbose
New-AzureRmResourceGroupDeployment -ResourceGroupName "elcalado-dev" -TemplateFile "C:\code\armwebcast\src\dev.json" -Verbose 

# Sample 4 - Tagging
$myTags = New-Object System.Collections.ArrayList
$myTags.Add(@{ Name="owner"; Value="calado"})
$myTags.Add(@{ Name="env"; Value="production"})

New-AzureRmResourceGroup -Name "elcalado-dev2" -Location "West Europe" -Tag $mytags -Force -Verbose 
New-AzureRmResourceGroupDeployment -ResourceGroupName "elcalado-dev2" -TemplateFile "C:\code\armwebcast\src\dev.json" -Verbose

# Sample 5 - Inside Tagging
$myTags = New-Object System.Collections.ArrayList
$myTags.Add(@{ Name="owner"; Value="calado"})
$myTags.Add(@{ Name="env"; Value="production"})
New-AzureRmResourceGroup -Name "elcalado-dev3" -Location "West Europe" -Tag $mytags -Force -Verbose 
New-AzureRmResourceGroupDeployment -ResourceGroupName "elcalado-dev3" -TemplateFile "C:\code\armwebcast\src\devtags.json" -Verbose

# Sample 6 - RBAC

# get role list
Get-AzureRmRoleDefinition | FT Name, Description
# get assignments for resource group
Get-AzureRmRoleAssignment -ResourceGroupName "elcalado-rbac"
# get role assignments for user
Get-AzureRmRoleAssignment -SignInName luis.calado@outlook.pt -ExpandPrincipalGroups
# add a new user role assignment to a resource group
New-AzureRmRoleAssignment -SignInName elcaladodpe@hotmail.com -RoleDefinitionName "Contributor" -ResourceGroupName "elcalado-rbac"
# remove role assignment for user
Remove-AzureRmRoleAssignment -ResourceGroupName "elcalado-rbac" -RoleDefinitionName "Contributor" -SignInName "elcaladodpe@hotmail.com" 
# get authorization audit log
Get-AzureRMAuthorizationChangeLog -StartTime ([DateTime]::Now - [TimeSpan]::FromDays(7)) | FT Caller,Action,RoleName,PrincipalType,PrincipalName,ScopeType,ScopeName

#Sample 7 - Resource Locking
New-AzureRmResourceLock -LockLevel CanNotDelete -LockNotes 'No deleting!' -LockName 'elcaladolock' -ResourceGroup 'elcalado-rbac' -Verbose 
Remove-AzureRmResourceLock -LockName "elcaladolock" -ResourceGroupName "elcalado-rbac"

#Sample 8 - Resource Group Export
Export-AzureRmResourceGroup -ResourceGroupName "elcalado-dev3" -Path c:\code\armwebcast\exports\dev3.json
Save-AzureRmResourceGroupDeploymentTemplate -DeploymentName devtags -ResourceGroupName elcalado-dev3 -Path c:\code\armwebcast\exports\dev.json

# Sample 9 - TODO App
New-AzureRmResourceGroup -Name "elcalado-todo" -Location "West Europe" -Force -Verbose
New-AzureRmResourceGroupDeployment -ResourceGroupName "elcalado-todo" -TemplateUri "c:\code\armwebcast\src\todo.json" -Verbose 
