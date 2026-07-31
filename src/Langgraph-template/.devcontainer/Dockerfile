FROM mcr.microsoft.com/devcontainers/python:3.11

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    jq \
    tree \
    ripgrep \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Devin CLI (without automatic setup/login)
USER vscode

RUN curl -fsSL https://cli.devin.ai/install.sh -o /tmp/devin-install.sh \
    && sed -i '${/^"\$VERSION_DIR\/bin\/\$COMPILED_BIN_NAME" setup$/d}' /tmp/devin-install.sh \
    && ! tail -n 1 /tmp/devin-install.sh | grep -q 'setup$' \
    && bash /tmp/devin-install.sh \
    && rm -f /tmp/devin-install.sh \
    && test -x "$(readlink -f "$HOME/.local/bin/devin")"

USER root

ENV NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt \
    GIT_SSL_CAINFO=/etc/ssl/certs/ca-certificates.crt \
    REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt \
    SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

ENV PATH=/home/vscode/.local/bin:${PATH}

USER vscode

WORKDIR /workspaces