#!/bin/sh
set -eu

PROBE_HOST="${CORP_PROBE_HOST:-github.com:443}"

if openssl s_client -connect "$PROBE_HOST" </dev/null 2>/dev/null \
   | grep -q 'Verify return code: 0 (ok)'; then
  echo "No TLS interception detected - public chain already trusted."
  exit 0
fi

if [ "$(id -u)" -ne 0 ]; then
  echo "REFUSING: interception detected but not running as root" >&2
  exit 1
fi

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

openssl s_client -showcerts -connect "$PROBE_HOST" </dev/null 2>/dev/null \
  | awk '/BEGIN CERT/,/END CERT/' > "$tmp/chain.pem"

csplit -sz -f "$tmp/c-" -b '%02d.pem' "$tmp/chain.pem" '/BEGIN CERTIFICATE/' '{*}'

root="$(ls "$tmp"/c-*.pem | tail -1)"
issuing="$(ls "$tmp"/c-*.pem | tail -2 | head -1)"

cp "$root" /usr/local/share/ca-certificates/corp-root.crt

if [ "$issuing" != "$root" ]; then
  cp "$issuing" /usr/local/share/ca-certificates/corp-issuing.crt
fi

update-ca-certificates