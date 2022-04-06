FROM mcr.microsoft.com/powershell:ubuntu-20.04

RUN pwsh \
    -NoLogo \
    -NoProfile \
    -Command " \
      \$ErrorActionPreference = 'Stop' ; \
      \$ProgressPreference = 'SilentlyContinue' ; \
      Install-Module -Name Az -RequiredVersion 7.3.2 -Force ; \
      Install-Module -Name Subnet -RequiredVersion 1.0.14 -Force ; \
      Start-Sleep -Seconds 10 ; \
      Import-Module -Name Az -Global; \
      Import-Module -Name Subnet -Global; \
      Start-Sleep -Seconds 6"
 
RUN pwsh \
    -NoLogo \
    -Command " \
      \$ErrorActionPreference = 'Stop' ; \
      \$ProgressPreference = 'SilentlyContinue' ; \
      Function lsla {Get-ChildItem -Force} ; \
      Set-Alias -Name "ls -la" -Value lsla"
