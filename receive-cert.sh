#!/bin/bash -e

# Usage: receive-cert.sh $CONFIG_NAME <<< "$CERT_CONTENT_BASE64 $KEY_CONTENT_BASE64"
# Usage: command="/opt/ssh-certdeploy/receive-cert.sh example",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty

source $(dirname "${BASH_SOURCE[0]}")/config.$1.sh
read -r CERT_CONTENT_BASE64 KEY_CONTENT_BASE64
CERT_CONTENT="$(echo "$CERT_CONTENT_BASE64" | base64 -d)"
KEY_CONTENT="$(echo "$KEY_CONTENT_BASE64" | base64 -d)"
if [[ "$CERT_FILE" != "" ]]; then
    echo "$CERT_CONTENT" > "$CERT_FILE"
fi
if [[ "$KEY_FILE" != "" ]]; then
    echo "$KEY_CONTENT" > "$KEY_FILE"
fi
if [[ "$RELOAD_CMD" != "" ]]; then
    $RELOAD_CMD
fi
if declare -F on_reload > /dev/null; then
    on_reload
fi
