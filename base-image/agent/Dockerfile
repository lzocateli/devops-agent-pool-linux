FROM nuuvedevops/azdo-agents:linux-x64-1.0.0

ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    jq \
    git \
    iputils-ping \
    libcurl4 \
    libunwind8 \
    netcat \
    libssl1.0 \
    zip \
    unzip \
    apt-utils \
    inetutils-traceroute \
    && rm -rf /var/lib/apt/lists/*

RUN curl -LsS https://aka.ms/InstallAzureCLIDeb | bash \
    && rm -rf /var/lib/apt/lists/*


ARG Env_HttpProxy
ARG Env_NoProxy

ENV HTTPS_PROXY=$Env_HttpProxy
ENV HTTP_PROXY=$Env_HttpProxy
ENV NO_PROXY=$Env_NoProxy

# Can be 'linux-x64', 'linux-arm64', 'linux-arm', 'rhel.6-x64'.
ENV TARGETARCH=linux-x64 

WORKDIR /agent

COPY ./*.ps1 ./
COPY . ./
RUN chmod +x *.ps1 *.sh

RUN ls -la

CMD ["./ConfigureOrRun.ps1", "/agent"]