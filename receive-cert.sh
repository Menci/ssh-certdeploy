#!/bin/bash -e

# Usage: receive-cert.sh $CONFIG_NAME <<< "$CERT_CONTENT_BASE64 $KEY_CONTENT_BASE64"
# Usage: command="/opt/ssh-certdeploy/receive-cert.sh example",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty

source $(dirname "${BASH_SOURCE[0]}")/config.$1.sh
read -r CERT_CONTENT_BASE64 KEY_CONTENT_BASE64
echo "$CERT_CONTENT_BASE64" | base64 -d > "$CERT_FILE"
echo "$KEY_CONTENT_BASE64" | base64 -d > "$KEY_FILE"
$RELOAD_CMD
