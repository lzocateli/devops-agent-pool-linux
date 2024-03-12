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
    if ([string]::IsNullOrWhiteSpace($env:AZP_DEPLOYMENT_POOL_NAME)) {
        $env:AZP_POOL = 'Default'
    }
    else {
        $env:AZP_POOL = ''
    }
} 

if ([string]::IsNullOrWhiteSpace($env:AZP_AGENT_NAME)) {
    if ([string]::IsNullOrWhiteSpace($env:COMPUTERNAME)) {
        $env:AZP_AGENT_NAME = $env:HOSTNAME
    }
    else {
        $env:AZP_AGENT_NAME = $env:COMPUTERNAME
    }

}
else {
    $env:AZP_AGENT_NAME = "$($env:AZP_AGENT_NAME)-$($env:HOSTNAME)"
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

$DEPLOYMENT_POOL_NAME = $env:AZP_DEPLOYMENT_POOL_NAME
$env:AZP_DEPLOYMENT_POOL_NAME = ""

$DEPLOYMENT_GROUP_TAGS = $env:AZP_DEPLOYMENT_GROUP_TAGS
$env:AZP_DEPLOYMENT_GROUP_TAGS = ""



$PROXY = $env:HTTP_PROXY 
$env:HTTPS_PROXY = ""
$env:https_proxy = ""
$env:http_proxy = ""
$env:no_proxy = ""

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
    Write-Host "deployment pool name: $DEPLOYMENT_POOL_NAME " -ForegroundColor Cyan
    Write-Host "deployment group tags: $DEPLOYMENT_GROUP_TAGS " -ForegroundColor Cyan
  

    Set-Item -Path Env:AGENT_ALLOW_RUNASROOT -Value "1"; 

    ./env.sh

    Get-ChildItem env:


    if ($false -eq [string]::IsNullOrWhiteSpace($DEPLOYMENT_POOL_NAME)) {
        if ([string]::IsNullOrWhiteSpace($DEPLOYMENT_GROUP_TAGS)) {
            Write-Error "Variavel AZP_DEPLOYMENT_GROUP_TAGS precisa ser informada, EX: AZP_DEPLOYMENT_GROUP_TAGS = ""web,prd"""
        }
    }


    if ([string]::IsNullOrWhiteSpace($env:HTTP_PROXY)) {

        Write-Host "Configuring without proxy in $PWD ..." -ForegroundColor Cyan

        if ([string]::IsNullOrWhiteSpace($DEPLOYMENT_POOL_NAME)) {
            ./config.sh --unattended `
                --url $URL `
                --pool $POOL `
                --auth PAT `
                --token $PAT `
                --agent $AGENT `
                --work $WORK `
                --replace `
                --acceptteeeula 
        }
        else {
            Write-Host "Configuring deployment pool $DEPLOYMENT_POOL_NAME" -ForegroundColor Cyan

            $configCommand = "./config.sh --unattended \`
            --deploymentpool \`
            --deploymentpoolname $DEPLOYMENT_POOL_NAME \`
            --deploymentGroupTags $DEPLOYMENT_GROUP_TAGS \`
            --addDeploymentGroupTags \`
            --url $URL \`
            --auth PAT \`
            --token $PAT \`
            --agent $AGENT \`
            --work $WORK \`
            --replace \`
            --acceptteeeula" 

            Write-Host $configCommand

            
            ./config.sh --unattended `
                --deploymentpool `
                --deploymentpoolname $DEPLOYMENT_POOL_NAME `
                --deploymentGroupTags $DEPLOYMENT_GROUP_TAGS `
                --addDeploymentGroupTags `
                --url $URL `
                --auth PAT `
                --token $PAT `
                --agent $AGENT `
                --work $WORK `
                --replace `
                --acceptteeeula 
        }
            
    }
    else {

        Write-Host "Configuring with proxy $($env:HTTP_PROXY) in $PWD ..." -ForegroundColor Cyan

        if ([string]::IsNullOrWhiteSpace($env:PROXY_USER)) {
            

            if ([string]::IsNullOrWhiteSpace($DEPLOYMENT_POOL_NAME)) {
                ./config.sh --unattended `
                    --url $URL `
                    --pool $POOL `
                    --auth PAT `
                    --token $PAT `
                    --agent $AGENT `
                    --work $WORK `
                    --proxyurl $PROXY `
                    --replace `
                    --acceptteeeula
            }
            else {
                Write-Host "Configuring proxy with deployment pool $DEPLOYMENT_POOL_NAME" -ForegroundColor Cyan

                ./config.sh --unattended `
                    --deploymentpool `
                    --deploymentpoolname $DEPLOYMENT_POOL_NAME `
                    --deploymentGroupTags `
                    --addDeploymentGroupTags $DEPLOYMENT_GROUP_TAGS `
                    --url $URL `
                    --auth PAT `
                    --token $PAT `
                    --agent $AGENT `
                    --work $WORK `
                    --proxyurl $PROXY `
                    --replace `
                    --acceptteeeula 
            }
        }
        else {
            

            if ([string]::IsNullOrWhiteSpace($DEPLOYMENT_POOL_NAME)) {
                ./config.sh --unattended `
                    --url $URL `
                    --pool $POOL `
                    --auth PAT `
                    --token $PAT `
                    --agent $AGENT `
                    --work $WORK `
                    --proxyurl $PROXY --proxyusername $env:PROXY_USER --proxypassword $env:PROXY_PASSWORD `
                    --replace `
                    --acceptteeeula 
            }
            else {
                Write-Host "Configuring proxy/userproxy with deployment pool $DEPLOYMENT_POOL_NAME" -ForegroundColor Cyan

                ./config.sh --unattended `
                    --deploymentpool `
                    --deploymentpoolname $DEPLOYMENT_POOL_NAME `
                    --deploymentGroupTags `
                    --addDeploymentGroupTags $DEPLOYMENT_GROUP_TAGS `
                    --url $URL `
                    --auth PAT `
                    --token $PAT `
                    --agent $AGENT `
                    --work $WORK `
                    --proxyurl $PROXY --proxyusername $env:PROXY_USER --proxypassword $env:PROXY_PASSWORD `
                    --replace `
                    --acceptteeeula 
            }
        }

    }


    Set-Location $ActualPath 

}
