FROM mcr.microsoft.com/azure-powershell:11.3.1-ubuntu-22.04

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
