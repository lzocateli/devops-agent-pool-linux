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


$pathAgentCredential = "$pathAgent/.credentials" 
if (-not (Test-Path $pathAgentCredential)) {

    $ActualPath = $PWD
    $PAT = $env:AZP_TOKEN
    $env:AZP_TOKEN = ""
    

    Set-Location $pathAgent
 
    Write-Host "Executing config.cmd CONFIGURE in $PWD ..." -ForegroundColor Cyan

    if ([string]::IsNullOrWhiteSpace($(HTTP_PROXY))) {

        ./config.sh `
            --url $env:AZP_URL `
            --pool $env:AZP_POOL `
            --auth PAT `
            --token $PAT `
            --agent $env:AZP_AGENT_NAME `
            --work $env:AZP_WORK `
            --unattended 
    }
    else {

        if ([string]::IsNullOrWhiteSpace($(PROXY_USER))) {
            
            ./config.sh `
                --url $env:AZP_URL `
                --pool $env:AZP_POOL `
                --auth PAT `
                --token $PAT `
                --agent $env:AZP_AGENT_NAME `
                --work $env:AZP_WORK `
                --unattended `
                --proxyurl $HTTP_PROXY
        }
        else {
            
            ./config.sh `
                --url $env:AZP_URL `
                --pool $env:AZP_POOL `
                --auth PAT `
                --token $PAT `
                --agent $env:AZP_AGENT_NAME `
                --work $env:AZP_WORK `
                --unattended `
                --proxyurl $HTTP_PROXY --proxyusername $PROXY_USER --proxypassword $PROXY_PASSWORD
        }

    }

    
    #    ./config.sh --proxyurl http://127.0.0.1:8888 --proxyusername "myuser" --proxypassword "mypass"
    
    Set-Location $ActualPath 

}