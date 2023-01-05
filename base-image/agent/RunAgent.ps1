#!/bin/pwsh


[CmdletBinding()] 
param(
  [Parameter(Position = 0, Mandatory, ValueFromPipeline)]
  [string]$pathAgent = "~/agent"
)

Write-Host "Starting: $($MyInvocation.MyCommand.Definition)"

Set-Location $pathAgent
    
Write-Host "Executing run-docker.sh in $PWD ..."

./run-docker.sh $pathAgent
