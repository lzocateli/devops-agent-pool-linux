#!/bin/pwsh
#Esse script esta sendo executado dentro do container

[CmdletBinding()] 
param(
  [Parameter(Position = 0, Mandatory, ValueFromPipeline)]
  [string]$pathAgent = "~/agent"
)

Write-Host "Starting: $($MyInvocation.MyCommand.Definition)"

Set-Item -Path Env:AZP_TOKEN -Value ""; 
[Environment]::SetEnvironmentVariable("AZP_TOKEN", '', 'Machine')
[Environment]::SetEnvironmentVariable("AZP_TOKEN", '', 'User')

Set-Location $pathAgent
    
Write-Host "Executing run.sh in $PWD ..."

./run.sh
