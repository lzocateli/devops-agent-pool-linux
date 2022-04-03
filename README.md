### Azure DevOps agent build with base Linux

## Supported

- [`scripts` (*agent-pool/scripts*)](https://github.com/lzocateli00/devops-agent-pool-linux/tree/main/agent)
- [`docker` (*agent-pool/Dockerfile*)](https://github.com/lzocateli00/devops-agent-pool-linux/tree/main/linux)

[![Downloads from Docker Hub](https://img.shields.io/docker/pulls/nuuvedevops/devops-agent-pool-linux.svg)](https://registry.hub.docker.com/u/nuuvedevops/devops-agent-pool-linux)
[![Stars on Docker Hub](https://img.shields.io/docker/stars/nuuvedevops/devops-agent-pool-linux.svg)](https://registry.hub.docker.com/u/nuuvedevops/devops-agent-pool-linux) 

[![](https://images.microbadger.com/badges/image/nuuvedevops/devops-agent-pool-linux.svg)](https://microbadger.com/images/nuuvedevops/devops-agent-pool-linux "Get your own image badge on microbadger.com")

[![](https://images.microbadger.com/badges/version/nuuvedevops/devops-agent-pool-linux.svg)](https://microbadger.com/images/nuuvedevops/devops-agent-pool-linux "Get your own version badge on microbadger.com")

## Configuration

For `agent`, you need to set these environment variables:

* `AZP_URL` - Required. The Azure DevOps organization
* `AZP_TOKEN` - Required. The personal access token PAT from Azure DevOps. 
* `AZP_POOL` - The agent pool. Optional. Default value: `Default`
* `AZP_AGENT_NAME` - Name of agent to be displayed in DevOps Agent Pool
* `AZP_WORK` - Folder where the build will be executed.  Default value: `_work`

## Running

On a Mac, use Docker for Mac, or directy on Linux, run in bash:

To start a container in detached mode:

````pwsh
docker run --name devops-agent01-linux `
    -d `
    -e AZP_URL=https://dev.azure.com/your_subscription/ `
    -e AZP_TOKEN=your PAT `
    -e AZP_POOL=your agent pool name `
    -e AZP_AGENT_NAME=your agent name `
    -e AZP_WORK=/agent/_work `
    -e HTTP_PROXY=http://proxy.domain.com:80 `
    -e HTTPS_PROXY=http://proxy.domain.com:80 `
    -e NO_PROXY=domain.com `
    -v /var/azagent-01:/data `
    nuuvedevops/devops-agent-pool-linux:linux-x64-agent-1.0.0 
````

To start a container in foreground mode:

````pwsh
docker run --name devops-agent01-linux `
    -ti `
    --rm `
    -e AZP_URL=https://dev.azure.com/your_subscription/ `
    -e AZP_TOKEN=your PAT `
    -e AZP_POOL=your agent pool name `
    -e AZP_AGENT_NAME=your agent name `
    -e AZP_WORK=/agent/_work `
    -e HTTP_PROXY=http://proxy.domain.com:80 `
    -e HTTPS_PROXY=http://proxy.domain.com:80 `
    -e NO_PROXY=domain.com `
    -v /var/azagent-01:/data `
    nuuvedevops/devops-agent-pool-linux:linux-x64-agent-1.0.0  
````

The -v parameter indicates that a volume is being mounted on the container host, 
so it will be possible to keep the _work folder even if the container is not running.
If you do not want to use a volume on the host, just remove the -v line from docker run.

## Step by Step
- git clone from this repository
- Edit file /devops-agent-pool-linux/agent/install-agent.ps1, change variable $agentVersion = "2.186.1"
- cd /devops-agent-pool-linux/docker
- execute: build-docker-agent.ps1 -dockerId xxxxx -dockerToken yyyyyyyyyyyyy
- A docker image will be created, run the command docker run (described above) or run-container.ps1 (which should be in your path)

## Maintainers

* [email: Lincoln Zocateli](mailto:lzocateli00@outlook.com), [facebook: Lincoln Zocateli](https://www.facebook.com/lzocateli00), [twitter: @lzocateli00](https://twitter.com/lzocateli00)

