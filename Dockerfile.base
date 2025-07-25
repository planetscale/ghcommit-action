FROM --platform=$TARGETARCH ghcr.io/planetscale/ghcommit:v0.1.74 AS ghcommit

# hadolint ignore=DL3007
FROM --platform=$TARGETARCH pscale.dev/wolfi-prod/base:latest AS base

COPY --from=ghcommit /ghcommit /usr/bin/ghcommit

# hadolint ignore=DL3018
RUN apk add --no-cache \
        bash \
        git-crypt \
        git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
