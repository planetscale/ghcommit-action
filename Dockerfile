FROM ghcr.io/planetscale/ghcommit:v0.1.49@sha256:38b4e2eba6e716ef596d913c52967fe135c5332e1c96fd638ef354184916baab AS ghcommit

# hadolint ignore=DL3007
FROM pscale.dev/wolfi-prod/base:latest AS base

COPY --from=ghcommit /ghcommit /usr/bin/ghcommit

# hadolint ignore=DL3018
RUN apk add --no-cache \
        bash \
        git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
