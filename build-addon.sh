#!/bin/bash
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

ADDON_NAME="shelly-manager"
DOCKER_REPO="ghcr.io/jfmlima"
VERSION=$(grep "^version:" shelly-manager/config.yaml | sed 's/version: *"\([^"]*\)".*/\1/')
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
    -t "${DOCKER_REPO}/addon-shelly-manager:latest" \
    -t "${DOCKER_REPO}/addon-shelly-manager:${VERSION}" \
    ./shelly-manager

echo -e "${GREEN}✓ Built multi-arch addon successfully${NC}"

echo ""
echo -e "${GREEN}✓ Multi-arch build completed successfully!${NC}"
echo -e "${YELLOW}Image: ${DOCKER_REPO}/addon-shelly-manager${NC}"
echo -e "${YELLOW}Tags: latest, ${VERSION}${NC}"
echo -e "${YELLOW}Platforms: ${PLATFORMS}${NC}"
echo ""