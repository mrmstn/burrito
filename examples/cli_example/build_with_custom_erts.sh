#!/bin/sh
# Build the example CLI app for several targets using a custom ERTS archive for
# the armv7 Linux target. The CUSTOM_ERTS_PATH environment variable must point
# to your armv7 Erlang/OTP tar.gz.

set -e

SCRIPT_DIR=$(dirname "$0")
cd "$SCRIPT_DIR"

mix deps.get

TARGETS="linux_aarch64 linux windows linux_armv7"

for T in $TARGETS; do
  echo "\n== Building $T =="
  BURRITO_TARGET=$T MIX_ENV=prod mix release
done

