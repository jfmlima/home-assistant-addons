#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Add-on: Shelly Manager
# Ensure /data directory is writable by the app user
# ==============================================================================

mkdir -p /data
chown app:app /data
