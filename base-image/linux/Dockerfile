FROM mcr.microsoft.com/azure-powershell:15.4.0-ubuntu-24.04

RUN pwsh \
    -NoLogo \
    -Command " \
      \$ErrorActionPreference = 'Stop' ; \
      \$ProgressPreference = 'SilentlyContinue' ; \
      Install-Module -Name Subnet -RequiredVersion 1.0.14 -Force ; \
      Import-Module -Name Subnet -Global ; \
      Function lsla {Get-ChildItem -Force} ; \
      Set-Alias -Name 'ls' -Value lsla -Force -Option AllScope"
