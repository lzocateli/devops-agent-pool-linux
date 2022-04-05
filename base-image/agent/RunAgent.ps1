#!/bin/pwsh


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
    
Write-Host "Executing run-docker.sh in $PWD ..."

./run-docker.sh
