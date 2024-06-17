FROM ghcr.io/planetscale/ghcommit:v0.1.48@sha256:9ebf836e2bdbb88e536984312a9083af8c95487ad2b59a1d830672bf4d9053ea AS ghcommit

FROM pscale.dev/wolfi-prod/base:latest AS base

COPY --from=ghcommit /ghcommit /usr/bin/ghcommit

RUN apk add --no-cache \
        bash \
        git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
