ARG VERSION=latest

FROM ghcr.io/coder/code-server:${VERSION}

USER root

ARG TARGETPLATFORM
# renovate: datasource=golang-version
ARG GOLANG_VERSION=1.25.3

RUN set -eux; \
    case "${TARGETPLATFORM}" in \
        "linux/amd64") GOARCH='amd64' ;; \
        "linux/arm64") GOARCH='arm64' ;; \
        *) echo "unsupported architecture: ${TARGETPLATFORM}"; exit 1 ;; \
    esac; \
    DL="https://go.dev/dl/go${GOLANG_VERSION}.linux-${GOARCH}.tar.gz"; \
    echo "Downloading Go from ${DL}"; \
    curl -fsSL "${DL}" -o /tmp/go.tar.gz; \
    tar -C /usr/local -xzf /tmp/go.tar.gz; \
    rm /tmp/go.tar.gz

ENV PATH="/usr/local/go/bin:${PATH}"
