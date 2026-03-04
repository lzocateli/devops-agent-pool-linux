FROM lzocateli/az-powershell-linux:15.4.0-ubuntu-24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes \
    && apt update -y \
    && apt upgrade -y \
    && apt install --no-install-recommends \
        ca-certificates \
        curl \
        jq \
        git \
        iputils-ping \
        libcurl4t64 \
        libunwind8 \
        netcat-openbsd \
        zip \
        unzip \
        apt-utils \
        inetutils-traceroute \
        gnupg \
        lsb-release \
    && curl -LsS https://aka.ms/InstallAzureCLIDeb | bash \
    && rm -rf /var/lib/apt/lists/*

ARG Env_HttpProxy
ARG Env_NoProxy

ENV HTTP_PROXY=$Env_HttpProxy
ENV NO_PROXY=$Env_NoProxy

# Can be 'linux-x64', 'linux-arm64', 'linux-arm', 'rhel.6-x64'.
ENV TARGETARCH=linux-x64 

WORKDIR /agent

# Desmarque isso caso for criar essa imagem dentro da sua infra
# Uncheck this if you are going to create this image within your infrastructure
#
# RUN git clone -b main https://github.com/lzocateli/devops-agent-pool-linux.git \
#     && mv ./devops-agent-pool-linux/base-image/agent/*.* . \
#     && rm -rf .git devops-agent-pool-linux


COPY ./*.ps1 ./
COPY . ./
RUN chmod +x *.ps1 *.sh \
    && chown -R $APP_UID:0 /agent \
    && chmod -R g=u /agent

USER $APP_UID

CMD ["pwsh","./ConfigureOrRun.ps1", "/agent"]
