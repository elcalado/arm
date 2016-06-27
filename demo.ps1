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
New-AzureRmResourceGroupDeployment -ResourceGroupName "elcalado-dev" -TemplateUri "C:\code\armwebcast\src\dev.json" -Verbose 
