Get-AzureSubscription

Login-AzureRmAccount
Select-AzureRmSubscription -SubscriptionId "ff0d44a7-e7f6-4a10-bfdf-3cbba8eddc36"

# Sample 1- Hello World
New-AzureRmResourceGroup -Name "elcalado-hello" -Location "West Europe" -Force -Verbose
New-AzureRmResourceGroupDeployment -ResourceGroupName "elcalado-hello" -TemplateFile "C:\code\armwebcast\src\helloWorld.json" -Verbose

# Sample 2 - Storage Account
New-AzureRmResourceGroup -Name "elcalado-store1" -Location "West Europe" -Force -Verbose
New-AzureRmResourceGroupDeployment -ResourceGroupName "elcalado-store1" -TemplateFile "C:\code\armwebcast\src\storageaccount.json" -Verbose

# Sample 3 - Web + SQL Dev / Test
New-AzureRmResourceGroup -Name "elcalado-dev" -Location "West Europe" -Force -Verbose
New-AzureRmResourceGroupDeployment -ResourceGroupName "elcalado-dev" -TemplateFile "C:\code\armwebcast\src\dev.json" -Verbose 


# Sample 4 - Tagging
$myTags = New-Object System.Collections.ArrList;
$myTags.Add(@{ Name="owner"; Value="calado"})
$myTags.Add(@{ Name="env"; Value="production"})

New-AzureRmResourceGroup -Name "elcalado-dev2" -Location "West Europe" -Tag $mytags -Force -Verbose 
New-AzureRmResourceGroupDeployment -ResourceGroupName "elcalado-dev2" -TemplateUri "C:\code\armwebcast\src\dev.json" -Verbose

# Sample 4 - Inside Tagging
New-AzureRmResourceGroup -Name "elcalado-dev3" -Location "West Europe" -Tag $mytags -Force -Verbose 
New-AzureRmResourceGroupDeployment -ResourceGroupName "elcalado-dev3" -TemplateUri "C:\code\armwebcast\src\devtags.json" -Verbose

