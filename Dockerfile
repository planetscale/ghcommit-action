FROM ghcr.io/planetscale/ghcommit:v0.1.44@sha256:a72c9694799b82443f712716b2e41e5ad6ac058f9f05ebdb0bd76023f3d48e5b AS ghcommit

FROM pscale.dev/wolfi-prod/base:latest AS base

COPY --from=ghcommit /ghcommit /usr/bin/ghcommit

RUN apk add --no-cache \
        bash \
        git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
