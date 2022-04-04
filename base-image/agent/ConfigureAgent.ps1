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
 
    Write-Host "Executing config.sh CONFIGURE in $PWD ..." -ForegroundColor Cyan

    Set-Item -Path Env:AGENT_ALLOW_RUNASROOT -Value "1"; 
    #export AGENT_ALLOW_RUNASROOT="1"

    ./env.sh


    if ([string]::IsNullOrWhiteSpace($HTTP_PROXY)) {

        Write-Host "Configuring without proxy in $PWD ..." -ForegroundColor Cyan

        ./config.sh --unattended `
            --url $env:AZP_URL `
            --pool $env:AZP_POOL `
            --auth PAT `
            --token $PAT `
            --agent "$env:AZP_AGENT_NAME-$env:HOSTNAME" `
            --work $env:AZP_WORK `
            --acceptTeeEula 
            
    }
    else {

        Write-Host "Configuring with proxy in $PWD ..." -ForegroundColor Cyan

        if ([string]::IsNullOrWhiteSpace($PROXY_USER)) {
            
            ./config.sh --unattended `
                --url $env:AZP_URL `
                --pool $env:AZP_POOL `
                --auth PAT `
                --token $PAT `
                --agent $env:AZP_AGENT_NAME `
                --work $env:AZP_WORK `
                --proxyurl $HTTP_PROXY `
                --acceptTeeEula 
        }
        else {
            
            ./config.sh --unattended `
                --url $env:AZP_URL `
                --pool $env:AZP_POOL `
                --auth PAT `
                --token $PAT `
                --agent $env:AZP_AGENT_NAME `
                --work $env:AZP_WORK `
                --proxyurl $HTTP_PROXY --proxyusername $PROXY_USER --proxypassword $PROXY_PASSWORD `
                --acceptTeeEula 
        }

    }


    Set-Location $ActualPath 

}