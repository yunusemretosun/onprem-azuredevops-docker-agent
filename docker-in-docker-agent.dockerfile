FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TARGETARCH=linux-x64
ENV AGENT_ALLOW_RUNASROOT="true"

# Sistem güncellemeleri ve temel gereksinimleri kurma
RUN apt-get update && apt-get upgrade -y && apt-get install -y -qq --no-install-recommends \
    apt-transport-https \
    apt-utils \
    ca-certificates \
    curl \
    openjdk-11-jdk \
    git \
    iputils-ping \
    jq \
    lsb-release \
    software-properties-common \
    gnupg-agent

# Azure CLI kurulumu
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Docker resmi GPG anahtarını ekleyin ve repository'i kurun
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    && apt-get update

# Docker CE, CLI, ve Containerd kurulumu
RUN apt-get install -y docker-ce docker-ce-cli containerd.io

# Docker Compose kurulumu
RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# Çalışma dizini
WORKDIR /azp

# Başlangıç script'ini kopyala ve çalıştırılabilir yap
COPY ./start.sh .
RUN chmod +x start.sh

# Entry point
ENTRYPOINT ["./start.sh"]