FROM ghcr.io/planetscale/ghcommit:v0.1.19@sha256:b1cfef367ebd5ccad4d15894801930fb359c614c42bcf1e160bf7380d5594a0c AS ghcommit

FROM pscale.dev/wolfi-prod/base:latest@sha256:c59f6e5fbb266934d2a63826045276f275e28ba2adb77a503ffbe7b5bc6a54da AS base

COPY --from=ghcommit /ghcommit /usr/bin/ghcommit

RUN apk add --no-cache \
        bash \
        git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
