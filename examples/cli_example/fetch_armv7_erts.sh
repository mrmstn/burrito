#!/bin/sh
# Fetch a prebuilt ERTS archive for the ARMv7 Linux target.
# The OTP_VERSION environment variable can be used to specify the version to fetch.
# Falls back to the 'erlang' version in ../../.tool-versions if not set.
# The archive is downloaded to custom_erts_armv7.tar.gz in the script directory.

set -e

SCRIPT_DIR=$(dirname "$0")
cd "$SCRIPT_DIR"

if [ -z "$OTP_VERSION" ]; then
  if [ -f ../../.tool-versions ]; then
    OTP_VERSION=$(grep '^erlang ' ../../.tool-versions | awk '{print $2}')
  fi
fi

if [ -z "$OTP_VERSION" ]; then
  echo "OTP_VERSION is not set and could not be determined" >&2
  exit 1
fi

OPENSSL_VERSION="3.1.4"
URL="https://beam-machine-universal.b-cdn.net/OTP-${OTP_VERSION}/linux/arm/any/otp_${OTP_VERSION}_linux_any_arm_ssl_${OPENSSL_VERSION}.tar.gz?please-respect-my-bandwidth-costs=thank-you"

OUTFILE="custom_erts_armv7.tar.gz"

echo "Downloading ERTS for OTP ${OTP_VERSION}..."
curl -L -o "$OUTFILE" "$URL"

echo "Saved ARMv7 ERTS archive to $OUTFILE"
