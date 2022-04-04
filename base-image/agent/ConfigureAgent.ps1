#!/bin/pwsh
#Esse script esta sendo executado dentro do container

[CmdletBinding()] 
param(
    [Parameter(Position = 0, Mandatory, ValueFromPipeline)]
    [string]$pathAgent = "~/agent"
)


Write-Host "Starting: $($MyInvocation.MyCommand.Definition)"


if ([string]::IsNullOrWhiteSpace($env:AZP_URL)) {
    Write-Host "Variable AZP_URL is not set"
    Exit 1
}
if ([string]::IsNullOrWhiteSpace($env:AZP_TOKEN)) {
    Write-Host "Variable AZP_TOKEN is not set"
    Exit 1
}

if ([string]::IsNullOrWhiteSpace($env:AZP_POOL)) {
    $env:AZP_POOL = 'Default'
}

if ([string]::IsNullOrWhiteSpace($env:AZP_AGENT_NAME)) {
    $env:AZP_AGENT_NAME = $env:COMPUTERNAME
}

if ([string]::IsNullOrWhiteSpace($env:AZP_WORK)) {
    $env:AZP_WORK = '_work'
}

if ($false -eq [string]::IsNullOrWhiteSpace($env:HTTP_PROXY)) {
    $env:PROXY_CONFIG = "--proxyurl $HTTP_PROXY --proxyusername $PROXY_USER --proxypassword $PROXY_PASSWORD"

    $arrayByPass = $NO_PROXY -split ","

    foreach ($item in $arrayByPass) {
        Write-Output $item.Trim() >>.proxybypass
    }
}


$pathAgentCredential = "$pathAgent/.credentials" 
if (-not (Test-Path $pathAgentCredential)) {

    $ActualPath = $PWD
    $PAT = $env:AZP_TOKEN
    $env:AZP_TOKEN = ""
    

    Set-Location $pathAgent
 
    Write-Host "Executing config.cmd CONFIGURE in $PWD ..." -ForegroundColor Cyan


    ./config.sh `
        --url $env:AZP_URL `
        --pool $env:AZP_POOL `
        --auth PAT `
        --token $PAT `
        --agent $env:AZP_AGENT_NAME `
        --work $env:AZP_WORK `
        --unattended `
        $PROXY_CONFIG
    
    #    ./config.sh --proxyurl http://127.0.0.1:8888 --proxyusername "myuser" --proxypassword "mypass"
    
    Set-Location $ActualPath 

}