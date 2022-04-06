##FROM mcr.microsoft.com/powershell:ubuntu-20.04
FROM mcr.microsoft.com/azure-powershell:7.4.0-ubuntu-20.04

## -NoProfile \
    
RUN pwsh \
    -NoLogo \
    -Command " \
      \$ErrorActionPreference = 'Stop' ; \
      \$ProgressPreference = 'SilentlyContinue' ; \
      Install-Module -Name Subnet -RequiredVersion 1.0.14 -Force ; \
      Import-Module -Name Subnet -Global"
 
RUN pwsh \
    -NoLogo \
    -Command " \
      \$ErrorActionPreference = 'Stop' ; \
      \$ProgressPreference = 'SilentlyContinue' ; \
      Function lsla {Get-ChildItem -Force} ; \
      Set-Alias -Name "ls" -Value lsla -Force -Option AllScope"
