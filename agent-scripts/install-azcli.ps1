#!/bin/pwsh
#Esse script esta sendo executado dentro do container

$localScript = $MyInvocation.MyCommand.Source.Replace($MyInvocation.MyCommand.Name, "")
$scriptName = $MyInvocation.MyCommand.Name
Write-Host "Start script: $localScript$scriptName at: $(Get-Date)"
  
$scriptAzDevOps = {

  az extension add --name azure-devops
  az extension list >azdevops.log
  
}


Write-Host "Donwloading and install AzureCLI ..."

Start-Process powershell -Verb runAs; `
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
  Invoke-WebRequest `
  -Uri https://aka.ms/installazurecliwindows `
  -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi
  

Write-Host "Donwloading and install az devops ..."

Invoke-Command -ScriptBlock $scriptAzDevOps