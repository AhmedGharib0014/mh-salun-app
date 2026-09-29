#!/usr/bin/env bash
#
# deploy_testflight.sh — Build the Flutter iOS app and upload it to TestFlight
# using an App Store Connect API key (.p8) stored in this folder.
#
# Prerequisite: bump the version in pubspec.yaml yourself before running,
# e.g. change `version: 1.0.0+3` to `version: 1.0.0+4`.
#
# Credentials: create scripts/ios-deployment/deploy_credentials.sh (gitignored) with:
#   ISSUER_ID="..."
#   KEY_ID="..."
#
# Usage:
#   ./scripts/ios-deployment/deploy_testflight.sh
#
set -euo pipefail

# ============================ CONFIG (edit once) ============================
TEAM_ID="8PWAWSR4G9"   # Paid team ID, matches ios/ExportOptions.plist
# ===========================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
KEY_DIR="$SCRIPT_DIR"   # Folder that contains AuthKey_XXXX.p8

RED=$'\033[31m'; GREEN=$'\033[32m'; BLUE=$'\033[34m'; RESET=$'\033[0m'
step() { echo; echo "${BLUE}==> $*${RESET}"; }
die()  { echo "${RED}ERROR: $*${RESET}" >&2; exit 1; }

# ---------- Checks ----------
step "Checking setup"
CREDENTIALS_FILE="$KEY_DIR/deploy_credentials.sh"
[[ -f "$CREDENTIALS_FILE" ]] || die "Missing $CREDENTIALS_FILE (must define ISSUER_ID and KEY_ID)"
# shellcheck source=/dev/null
source "$CREDENTIALS_FILE"
: "${ISSUER_ID:?ISSUER_ID not set in $CREDENTIALS_FILE}"
: "${KEY_ID:?KEY_ID not set in $CREDENTIALS_FILE}"

EXPORT_PLIST="$PROJECT_DIR/ios/ExportOptions.plist"

KEY_PATH="$KEY_DIR/AuthKey_${KEY_ID}.p8"
[[ -f "$KEY_PATH" ]] || die "Key not found: $KEY_PATH"
echo "Key:     $KEY_PATH"
echo "Key ID:  $KEY_ID"
echo "Team ID: $TEAM_ID"

AUTH_ARGS=(
  -allowProvisioningUpdates
  -authenticationKeyPath "$KEY_PATH"
  -authenticationKeyID "$KEY_ID"
  -authenticationKeyIssuerID "$ISSUER_ID"
)

# ---------- Read version from pubspec.yaml ----------
PUBSPEC="$PROJECT_DIR/pubspec.yaml"
CURRENT="$(grep -E '^version:' "$PUBSPEC" | head -1 | awk '{print $2}')"
[[ -n "$CURRENT" ]] || die "No 'version:' line in pubspec.yaml"
VERSION_NAME="${CURRENT%%+*}"
BUILD_NUMBER="${CURRENT#*+}"
echo "Version: $CURRENT"

read -r -p "Have you already bumped the version in pubspec.yaml for this release? [y/N] " CONFIRM
[[ "$CONFIRM" =~ ^[Yy]$ ]] || die "Bump the version in pubspec.yaml first, then re-run."

# ---------- Flutter prepare ----------
step "Preparing Flutter iOS build"
cd "$PROJECT_DIR"
flutter clean
flutter pub get
flutter build ios --release --config-only \
  --build-name="$VERSION_NAME" --build-number="$BUILD_NUMBER"

# ---------- Archive ----------
step "Archiving (this takes a few minutes)"
cd "$PROJECT_DIR/ios"
BUILD_DIR="$PROJECT_DIR/ios/build"
ARCHIVE_PATH="$BUILD_DIR/Runner.xcarchive"
rm -rf "$ARCHIVE_PATH" "$BUILD_DIR/ipa"
mkdir -p "$BUILD_DIR"

xcodebuild archive \
  -workspace Runner.xcworkspace \
  -scheme Runner \
  -configuration Release \
  -destination 'generic/platform=iOS' \
  -archivePath "$ARCHIVE_PATH" \
  "${AUTH_ARGS[@]}" \
  DEVELOPMENT_TEAM="$TEAM_ID" \
  CODE_SIGN_STYLE=Automatic

# ---------- Export + upload ----------
step "Uploading to App Store Connect / TestFlight"
xcodebuild -exportArchive \
  -archivePath "$ARCHIVE_PATH" \
  -exportPath "$BUILD_DIR/ipa" \
  -exportOptionsPlist "$EXPORT_PLIST" \
  "${AUTH_ARGS[@]}"

# ---------- Done ----------
echo
echo "${GREEN}Uploaded version ${CURRENT} to App Store Connect.${RESET}"
echo "It will appear in TestFlight after Apple finishes processing (usually 5-30 min)."
