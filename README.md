### Azure DevOps agent build with base Linux

## Supported

- [`agent` (*Dockerfile*)](https://github.com/lzocateli00/devops-agent-pool-linux/tree/main/base-image/agent)
- [`base-image` (*Dockerfile*)](https://github.com/lzocateli00/devops-agent-pool-linux/tree/main/base-image/linux)

| Click to DockerHub | Version |
| :---:   | :---:     |
| ![Docker Pulls](https://img.shields.io/docker/pulls/lzocateli/devops-agent-pool-linux-x64) | ![Docker Image Version (latest semver)](https://img.shields.io/docker/v/lzocateli/devops-agent-pool-linux-x64) |

## Configuration

For `agent`, you need to set these environment variables in `/etc/profile`: 

```bash
export AZ_AGENT_WORK_PATH=agent-01
export AZ_AGENT_NAME=$(awk -v azhostname="$HOSTNAME" 'BEGIN {str=azhostname; split(str, arr, "."); { print arr[1]}}')
export AZ_DEPLOYMENT_GROUP_TAGS=qas  # or prd  Pay attention in environment where your machine belongs
export AZ_DEPLOYMENT_POOL_NAME=LZ-LINUX
```

```bash
#Execute
source /etc/profile

mkdir -p /var/$AZ_AGENT_WORK_PATH
```

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
* `AZP_DEPLOYMENT_POOL_NAME` - If informed, a Deployment Pool type agent will be created
* `AZP_DEPLOYMENT_GROUP_TAGS` - Used with AZP_DEPLOYMENT_POOL_NAME, to specify the comma separated list of tags for the deployment group agent - for example "web, db"


## Running

On a Mac, use Docker for Mac, or directy on Linux, run in bash:

To start a container in foreground mode: `docker run -ti --rm`

To start a container in detached mode:

```powershell
docker run --name devops-$AZ_AGENT_WORK_PATH `
    -d `
    -e AZP_URL=https://dev.azure.com/your_subscription `
    -e AZP_TOKEN=####your PAT#### `
    -e AZP_POOL=your agent pool name `
    -e AZP_AGENT_NAME=$AZ_AGENT_NAME `
    -e AZP_WORK=/agent/_work `
    -e HTTP_PROXY=http://proxy.domain.com:80 `
    -e NO_PROXY=domain.com `
    -e PROXY_USER=myuser `
    -e PROXY_PASSWORD=XYZ `
    -v /var/$AZ_AGENT_WORK_PATH:/agent/_work `
    lzocateli/devops-agent-deploypool-linux:1.0.0
```


To run a container with a `deployment pool` agent

```powershell
docker run --name devops-$AZ_AGENT_WORK_PATH `
    -d `
    -e AZP_DEPLOYMENT_POOL_NAME=$AZ_DEPLOYMENT_POOL_NAME `
    -e AZP_DEPLOYMENT_GROUP_TAGS=$AZ_DEPLOYMENT_GROUP_TAGS `
    -e AZP_URL=https://dev.azure.com/your_subscription `
    -e AZP_TOKEN=####your PAT#### `
    -e AZP_AGENT_NAME=$AZ_AGENT_NAME `
    -e AZP_WORK=/agent/_work `
    -e HTTP_PROXY=http://proxy.domain.com:80 `
    -e NO_PROXY=domain.com `
    -e PROXY_USER=myuser `
    -e PROXY_PASSWORD=XYZ `
    -v /var/$AZ_AGENT_WORK_PATH:/agent/_work `
    lzocateli/devops-agent-deploypool-linux:1.0.0 
```

To podman:

```powershell
-v /var/$AZ_AGENT_WORK_PATH:/agent/_work:z
```


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

