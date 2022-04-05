#!/bin/pwsh


[CmdletBinding()] 
param(
  [Parameter(Position = 0, Mandatory, ValueFromPipeline)]
  [string]$pathAgent = "~/agent"
)

Write-Host "Starting: $($MyInvocation.MyCommand.Definition)"

[Environment]::SetEnvironmentVariable("AZP_TOKEN", '', 'Machine')
[Environment]::SetEnvironmentVariable("AZP_TOKEN", '', 'User')
[Environment]::SetEnvironmentVariable("AZP_AGENT_NAME", '', 'Machine')
[Environment]::SetEnvironmentVariable("AZP_AGENT_NAME", '', 'User')

Set-Location $pathAgent
    
Write-Host "Executing run-docker.sh in $PWD ..."

./run-docker.sh
