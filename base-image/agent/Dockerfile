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
    && rm -rf /var/lib/apt/lists/*

RUN curl -LsS https://aka.ms/InstallAzureCLIDeb | bash \
    && rm -rf /var/lib/apt/lists/*

#    libicu60 \

ARG Env_HttpProxy
ARG Env_NoProxy
ARG Env_UrlYourDevOps
ARG Env_PatYourDevOps

ENV HTTPS_PROXY=$Env_HttpProxy
ENV HTTP_PROXY=$Env_HttpProxy
ENV NO_PROXY=$Env_NoProxy

# Can be 'linux-x64', 'linux-arm64', 'linux-arm', 'rhel.6-x64'.
ENV TARGETARCH=linux-x64 

WORKDIR /azp

COPY ./*.ps1 ./
COPY ./.proxybypass .
RUN chmod +x *.ps1

RUN ./install-agent.ps1 -pathAgent $PWD -targetArchPlataform $TARGETARCH -urlYourDevOps $Env_UrlYourDevOps -patYourDevOps $Env_PatYourDevOps

# ENTRYPOINT ["./start.sh"]
CMD ["./ConfigureOrRun.ps1"]