#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Add-on: Fix Asset Paths for Ingress
# ==============================================================================

bashio::log.info "Fixing asset paths for Home Assistant ingress..."

# Fix the HTML file to use relative paths instead of absolute paths
sed -i 's|href="/vite.svg"|href="./vite.svg"|g' /var/www/html/index.html
sed -i 's|src="/assets/|src="./assets/|g' /var/www/html/index.html
sed -i 's|href="/assets/|href="./assets/|g' /var/www/html/index.html

bashio::log.info "Asset paths fixed for ingress compatibility"
