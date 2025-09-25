#!/bin/bash
# Build script for Shelly Manager Home Assistant Addon

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
ADDON_NAME="shelly-manager"
DOCKER_REPO="ghcr.io/jfmlima"
VERSION="1.0.0"

# Supported platforms (handled by multi-arch build)
PLATFORMS="linux/amd64,linux/arm64"

echo -e "${GREEN}Building Shelly Manager Home Assistant Addon${NC}"
echo -e "${YELLOW}Version: ${VERSION}${NC}"
echo ""

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo -e "${RED}Error: Docker is not running${NC}"
    exit 1
fi

# Enable Docker buildx for multi-platform builds
docker buildx create --use --name multiplatform 2>/dev/null || docker buildx use multiplatform

# Build multi-arch image
echo -e "${YELLOW}Building multi-arch addon image...${NC}"
echo -e "${YELLOW}Platforms: linux/amd64, linux/arm64${NC}"

docker buildx build \
    --platform "linux/amd64,linux/arm64" \
    --build-arg "BUILD_VERSION=${VERSION}" \
    -f "shelly-manager/Dockerfile" \
    -t "${DOCKER_REPO}/home-assistant-addons/${ADDON_NAME}:${VERSION}" \
    -t "${DOCKER_REPO}/home-assistant-addons/${ADDON_NAME}:latest" \
    ./shelly-manager

echo -e "${GREEN}✓ Built multi-arch addon successfully${NC}"

echo ""
echo -e "${GREEN}✓ Multi-arch build completed successfully!${NC}"
echo -e "${YELLOW}Image: ${DOCKER_REPO}/home-assistant-addons/${ADDON_NAME}${NC}"
echo -e "${YELLOW}Tags: ${VERSION}, latest${NC}"
echo -e "${YELLOW}Platforms: ${PLATFORMS}${NC}"
echo ""