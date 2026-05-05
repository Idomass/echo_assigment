ARG GOSU_VERSION=1.17
ARG GO_VERSION=1.25

# Stage 1: build gosu from source with a fresh Go toolchain.
# This eliminates the Go-stdlib CVEs that ride along with the prebuilt
# gosu binary shipped in redis:7-bookworm (originally built with go1.18.2).
FROM golang:${GO_VERSION}-bookworm AS gosu-builder

ARG GOSU_VERSION
ARG TARGETOS
ARG TARGETARCH

RUN apt-get update \
 && apt-get install -y --no-install-recommends git ca-certificates \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /src
RUN git clone --depth 1 --branch ${GOSU_VERSION} https://github.com/tianon/gosu.git .

ENV CGO_ENABLED=0 \
    GOFLAGS=-trimpath
RUN GOOS=${TARGETOS:-linux} GOARCH=${TARGETARCH:-amd64} \
    go build \
        -ldflags '-s -w -extldflags "-static"' \
        -o /out/gosu \
 && /out/gosu --version

# Stage 2: final image — drop the freshly built gosu over the stock one.
FROM redis:7-bookworm

COPY --from=gosu-builder /out/gosu /usr/local/bin/gosu
RUN chmod 0755 /usr/local/bin/gosu \
 && gosu --version \
 && gosu nobody true
