# Start from Ubuntu
FROM ubuntu:24.04

# Set noninteractive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    vim \
    ca-certificates \
    apt-transport-https \
    gnupg \
    libnss3-tools \
    && rm -rf /var/lib/apt/lists/*

# Install Go
ENV GOLANG_VERSION=1.24.0
RUN wget https://go.dev/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz -O /tmp/go.tgz \
    && tar -C /usr/local -xzf /tmp/go.tgz \
    && rm /tmp/go.tgz
ENV PATH=$PATH:/usr/local/go/bin

# Install kubectl
RUN curl -fsSLo /usr/local/bin/kubectl https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x /usr/local/bin/kubectl

# Install mkcert
RUN curl -L https://github.com/FiloSottile/mkcert/releases/latest/download/mkcert-v1.4.4-linux-amd64 \
    -o /usr/local/bin/mkcert \
    && chmod +x /usr/local/bin/mkcert

# Verify installs
RUN go version && git --version && kubectl version --client && vim --version && mkcert --version

# Default workdir
WORKDIR /workspace
