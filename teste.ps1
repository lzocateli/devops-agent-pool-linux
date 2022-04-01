#!/bin/pwsh

[System.Environment]::SetEnvironmentVariable()

Invoke-WebRequest `
    -Uri "$env:AZP_URL/_apis/distributedtask/packages/agent?platform=$env:TARGETARCH&top=1" `
    -OutFile $destinationPack