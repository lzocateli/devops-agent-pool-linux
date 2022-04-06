#!/bin/pwsh

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


$PAT = $env:AZP_TOKEN
$env:AZP_TOKEN = ""

$URL = $env:AZP_URL
$env:AZP_URL = ""

$POOL = $env:AZP_POOL
$env:AZP_POOL = ""

$AGENT = $env:AZP_AGENT_NAME
$env:AZP_AGENT_NAME = ""

$WORK = $env:AZP_WORK
$env:AZP_WORK = ""

$PROXY = $env:HTTP_PROXY 
$env:HTTP_PROXY = ""
    

$pathAgentCredential = "$pathAgent/.credentials" 
if (-not (Test-Path $pathAgentCredential)) {

    $ActualPath = $PWD
   
    Set-Location $pathAgent
 
    Write-Host "Executing config.sh CONFIGURE in $PWD ... " -ForegroundColor Cyan
    Write-Host "url: $URL " -ForegroundColor Cyan
    Write-Host "pool: $POOL " -ForegroundColor Cyan
    Write-Host "token: $PAT " -ForegroundColor Cyan
    Write-Host "agent: $AGENT " -ForegroundColor Cyan
    Write-Host "work: $WORK " -ForegroundColor Cyan
    Write-Host "proxy: $PROXY " -ForegroundColor Cyan
  

    Set-Item -Path Env:AGENT_ALLOW_RUNASROOT -Value "1"; 

    ./env.sh


    if ([string]::IsNullOrWhiteSpace($env:HTTP_PROXY)) {

        Write-Host "Configuring without proxy in $PWD ..." -ForegroundColor Cyan

        ./config.sh --unattended `
            --url $URL `
            --pool $POOL `
            --auth PAT `
            --token $PAT `
            --agent $AGENT `
            --work $WORK `
            --replace `
            --acceptTeeEula 
            
    }
    else {

        Write-Host "Configuring with proxy $($env:HTTP_PROXY) in $PWD ..." -ForegroundColor Cyan

        if ([string]::IsNullOrWhiteSpace($env:PROXY_USER)) {
            
            ./config.sh --unattended `
                --url $URL `
                --pool $POOL `
                --auth PAT `
                --token $PAT `
                --agent $AGENT `
                --work $WORK `
                --proxyurl $PROXY `
                --replace `
                --acceptTeeEula 
        }
        else {
            
            ./config.sh --unattended `
                --url $URL `
                --pool $POOL `
                --auth PAT `
                --token $PAT `
                --agent $AGENT `
                --work $WORK `
                --proxyurl $PROXY --proxyusername $env:PROXY_USER --proxypassword $env:PROXY_PASSWORD `
                --replace `
                --acceptTeeEula 
        }

    }


    Set-Location $ActualPath 

}
