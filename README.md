### Azure DevOps agent build with base Linux

## Supported

- [`agent` (*Dockerfile*)](https://github.com/lzocateli00/devops-agent-pool-linux/tree/main/base-image/agent)
- [`base-image` (*Dockerfile*)](https://github.com/lzocateli00/devops-agent-pool-linux/tree/main/base-image/linux)

| Click to DockerHub | Version |
| :---:   | :---:     |
| [![Docker Pulls](https://img.shields.io/docker/pulls/nuuvedevops/azdo-agents)](https://hub.docker.com/r/nuuvedevops/azdo-agents) | [![Docker Image Version (latest semver)](https://img.shields.io/docker/v/nuuvedevops/azdo-agents?sort=semver)](https://hub.docker.com/r/nuuvedevops/azdo-agents) |

## Configuration

For `agent`, you need to set these environment variables:

* `AZP_URL` - Required. The Azure DevOps organization
* `AZP_TOKEN` - Required. The personal access token PAT from Azure DevOps. 
* `AZP_POOL` - The agent pool. Optional. Default value: `Default`
* `AZP_AGENT_NAME` - Name of agent to be displayed in DevOps Agent Pool
* `AZP_WORK` - Folder where the build will be executed.  Default value: `_work`

Optionals environment variables:

* `HTTP_PROXY` - If you have to use a proxy, this is where you should inform it
* `NO_PROXY` - List of domains that should not go through the proxy (serated by comma) Example: meudns.com,github.com
(see **"Attention, if you use proxy"**)
* `PROXY_USER` - If necessary, inform the username for proxy authentication
* `PROXY_PASSWORD` - If necessary, inform the password for proxy authentication


## Running

On a Mac, use Docker for Mac, or directy on Linux, run in bash:

To start a container in detached mode:

````pwsh
docker run --name devops-agent01 `
    -d `
    -e AZP_URL=https://dev.azure.com/your_subscription `
    -e AZP_TOKEN=your PAT `
    -e AZP_POOL=your agent pool name `
    -e AZP_AGENT_NAME=your agent name `
    -e AZP_WORK=/agent/_work `
    -e HTTP_PROXY=http://proxy.domain.com:80 `
    -e NO_PROXY=domain.com `
    -e PROXY_USER=myuser `
    -e PROXY_PASSWORD=XYZ `
    -v /var/azagent-01:/agent/_work ` to podman `-v /var/azagent-01:/agent/_work:z`
    nuuvedevops/devops-agent-pool-linux:linux-x64-agent-1.0.0 
````

To start a container in foreground mode:

````pwsh
docker run --name devops-agent01 `
    -ti `
    --rm `
    -e AZP_URL=https://dev.azure.com/your_subscription `
    -e AZP_TOKEN=your PAT `
    -e AZP_POOL=your agent pool name `
    -e AZP_AGENT_NAME=your agent name `
    -e AZP_WORK=/agent/_work `
    -e HTTP_PROXY=http://proxy.domain.com:80 `
    -e NO_PROXY=domain.com `
    -e PROXY_USER=myuser `
    -e PROXY_PASSWORD=XYZ `
    -v /var/azagent-01:/agent/_work ` to podman `-v /var/azagent-01:/agent/_work:z`
    nuuvedevops/devops-agent-pool-linux:linux-x64-agent-1.0.0  
````

The -v parameter indicates that a volume is being mounted on the container host, 
so it will be possible to keep the _work folder even if the container is not running.

If you do not want to use a volume on the host, just remove the -v line from docker run.

**Remember if:**
- Path to the left of : is the host path
- Path to the right of : is the path inside the container   

**Podman volumes:**
- Use `:z` in the volume mount instruction, or `--security-opt label=disable` if using a SELinux system, Example:
```pwsh
podman run --security-opt label=disable -v .....
```

## Attention, if you use proxy
* If you are using a proxy, and you have domains in "NO_PROXY", you will need to do this step by step:
    1. git clone from this repository
    2. Create the `.proxybypass` file inside the `/base-image/agent/` folder
    3. Run the command to create your image, as instructed in: `/base-image/agent/readme.md`  

## Maintainers

* `Lincoln Zocateli`: e-mail: [lzocateli00@outlook.com](mailto:lzocateli00@outlook.com), facebook: [lzocateli00](https://www.facebook.com/lzocateli00), twitter: [lzocateli00](https://twitter.com/lzocateli00)

