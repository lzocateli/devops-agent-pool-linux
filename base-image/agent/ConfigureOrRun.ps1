#!/bin/pwsh
#Esse script esta sendo executado dentro do container

[CmdletBinding()] 
param(
  [Parameter(Position = 0, Mandatory, ValueFromPipeline)]
  [string]$pathAgent = "~/agent"
)


Write-Host "Starting: $($MyInvocation.MyCommand.Definition)"


$pathAgentCredential = "$pathAgent/.credentials" 

if (-not (Test-Path $pathAgentCredential)) {
  Write-Host "ConfigureAndRun agent ...."
  ./ConfigureAndRun.ps1 $pathAgent
}
else {
  Write-Host "RunAgent background ...."
  ./RunAgent.ps1 $pathAgent
}

