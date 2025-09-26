
ARG BUILD_FROM=ghcr.io/hassio-addons/base:stable

FROM ghcr.io/jfmlima/shelly-manager-api:latest AS api-source
FROM ghcr.io/jfmlima/shelly-manager-web:latest AS web-source

FROM ghcr.io/hassio-addons/base:stable

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apk add --no-cache \
        python3 \
        py3-pip \
        curl \
        nginx \
    && adduser -D -u 10001 app

COPY --from=api-source --chown=app:app /app/packages/core /app/packages/core
COPY --from=api-source --chown=app:app /app/packages/api /app/packages/api

COPY --from=web-source /usr/share/nginx/html /var/www/html/

WORKDIR /app
RUN python3 -m venv .venv \
    && . .venv/bin/activate \
    && pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir /app/packages/core /app/packages/api \
    && rm -rf /root/.cache/pip

ENV PATH="/app/.venv/bin:$PATH" \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

COPY rootfs /

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:8000/api/health || curl -f http://localhost:8000/api/ || exit 1

LABEL \
    io.hass.name="Shelly Manager" \
    io.hass.description="Local management for Shelly IoT devices without cloud connectivity" \
    io.hass.type="addon" \
    io.hass.version="latest" \
    maintainer="jfmlima" \
    org.opencontainers.image.title="Shelly Manager" \
    org.opencontainers.image.description="Local management for Shelly IoT devices without cloud connectivity" \
    org.opencontainers.image.vendor="Shelly Manager" \
    org.opencontainers.image.source="https://github.com/jfmlima/shelly-manager" \
    org.opencontainers.image.documentation="https://github.com/jfmlima/shelly-manager/blob/main/shelly-manager/DOCS.md" \
    org.opencontainers.image.licenses="MIT"