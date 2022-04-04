#!/bin/pwsh
#Esse script esta sendo executado dentro do container

[CmdletBinding()] 
param(
  [Parameter(Position = 0, Mandatory, ValueFromPipeline)]
  [string]$pathAgent = "~/agent"
)


Write-Host "Starting: $($MyInvocation.MyCommand.Definition)"

if (-not (Test-Path $pathAgent)) {
  Write-Host "Path agent: $pathAgent not found"
  Exit 1
}


$agentName = "Agent.Listener"
Write-Host "Stopping $agentName ..."
Get-Process -Name $agentName
Stop-Process -Name $agentName


Write-Host "Starting configuration for $env:HOSTNAME ...  in $pathAgent"
./ConfigureAgent.ps1 $pathAgent

[Int32]$zero = 0
if ($LASTEXITCODE -eq $zero) {
  Write-Host "Configuration done. Starting run for $env:HOSTNAME ...  in $pathAgent"
  ./RunAgent.ps1 $pathAgent
}