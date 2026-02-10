#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
APP_NAME="NothingStatusBar"
CONFIGURATION="${1:-release}"
OUTPUT_DIR="${ROOT_DIR}/dist"
APP_BUNDLE_PATH="${OUTPUT_DIR}/${APP_NAME}.app"

if [[ "${CONFIGURATION}" != "debug" && "${CONFIGURATION}" != "release" ]]; then
    echo "Usage: $0 [debug|release]"
    exit 1
fi

swift build \
    --package-path "${ROOT_DIR}" \
    --configuration "${CONFIGURATION}" \
    --product "${APP_NAME}"

BIN_PATH="$(swift build \
    --package-path "${ROOT_DIR}" \
    --configuration "${CONFIGURATION}" \
    --show-bin-path)"
EXECUTABLE_PATH="${BIN_PATH}/${APP_NAME}"

if [[ ! -x "${EXECUTABLE_PATH}" ]]; then
    echo "Executable not found: ${EXECUTABLE_PATH}"
    exit 1
fi

rm -rf "${APP_BUNDLE_PATH}"
mkdir -p "${APP_BUNDLE_PATH}/Contents/MacOS"

cp "${ROOT_DIR}/BuildSupport/Info.plist" "${APP_BUNDLE_PATH}/Contents/Info.plist"
cp "${EXECUTABLE_PATH}" "${APP_BUNDLE_PATH}/Contents/MacOS/${APP_NAME}"
chmod +x "${APP_BUNDLE_PATH}/Contents/MacOS/${APP_NAME}"

if command -v codesign >/dev/null 2>&1; then
    codesign --force --sign - "${APP_BUNDLE_PATH}" >/dev/null
fi

echo "Created: ${APP_BUNDLE_PATH}"
echo "Install (recommended): cp -R \"${APP_BUNDLE_PATH}\" /Applications/"
