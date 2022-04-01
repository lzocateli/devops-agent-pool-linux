# https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops#windows
# docker login configure:
# https://docs.docker.com/engine/reference/commandline/login/#credentials-store

[CmdletBinding()] 
param(
    [Parameter(Position = 0, ValueFromPipeline)]
    [string] $dockerId,
    [Parameter(Position = 1, ValueFromPipeline)]
    [string] $dockerToken
)

Write-Host "========================================================================================="

$localScript = $MyInvocation.MyCommand.Source.Replace($MyInvocation.MyCommand.Name, "")
$scriptName = $MyInvocation.MyCommand.Name
Write-Host "Start script: $localScript$scriptName at: $(Get-Date)"


$fileToCheck = "Dockerfile"
if (-not (Test-Path $fileToCheck -PathType leaf)) {
    Write-Error "error: $fileToCheck not exists in $PWD"
    exit 1
}

if ($false -eq [string]::IsNullOrWhiteSpace($dockerId)) {
  if ([string]::IsNullOrWhiteSpace($dockerToken)) {
      docker login -u $dockerId --password-stdin
  }
  else {
      docker login -u $dockerId -p $dockerToken
  }
}


$BuildDate = date -u +"%Y-%m-%dT%H:%M:%SZ"
$GitUrl = git config --get remote.origin.url
$GitCommit = git rev-parse --short HEAD
$CodeVersion = "1.0.0"
$imageName = "devops-agent-pool-win"
$imageTag = "1.0.0"
$DockerBuildT = "$dockerId/${imageName}:$imageTag"

docker build `
  --build-arg BUILD_DATE=$BuildDate `
  --build-arg VERSION=$CodeVersion `
  --build-arg VCS_URL=$GitUrl `
  --build-arg VCS_REF=$GitCommit `
	-t $DockerBuildT .

docker images
