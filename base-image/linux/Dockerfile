FROM mcr.microsoft.com/powershell:ubuntu-20.04

RUN pwsh \
    -NoLogo \
    -NoProfile \
    -Command " \
      \$ErrorActionPreference = 'Stop' ; \
      \$ProgressPreference = 'SilentlyContinue' ; \
      Install-Module -Name Az.Accounts -RequiredVersion 2.7.1 ; \
      Install-Module -Name Subnet -RequiredVersion 1.0.14 ; \
      Start-Sleep -Seconds 10 ; \
      Import-Module -Name Az.Accounts -Global; \
      Import-Module -Name Subnet -Global; \
      Start-Sleep -Seconds 6"
 
