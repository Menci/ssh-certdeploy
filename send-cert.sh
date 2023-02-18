#!/bin/bash -e

# Usage: send-certs.sh "$USER_AT_HOST" "$POST" "$KNOWN_HOSTS_CONTENT" "$SSH_PRIVATE_KEY_FILE" "$CERT_FILE" "$KEY_FILE"

USER_AT_HOST="$1"
PORT="$2"
KNOWN_HOSTS_CONTENT="$3"
SSH_PRIVATE_KEY_FILE="$4"
CERT_FILE="$5"
KEY_FILE="$6"

KNOWN_HOSTS_FILE="$(mktemp -p /tmp)"
trap '{ rm -f -- "$KNOWN_HOSTS_FILE"; }' EXIT
echo "$KNOWN_HOSTS_CONTENT" > "$KNOWN_HOSTS_FILE"

(
    cat "$CERT_FILE" | base64 -w0
    echo -n " "
    cat "$KEY_FILE" | base64 -w0
    echo
) | (
    SSH_AUTH_SOCK= ssh -T \
                       -i "$SSH_PRIVATE_KEY_FILE" \
                       -p "$PORT" \
                       -o "UserKnownHostsFile=$KNOWN_HOSTS_FILE" \
                       "$USER_AT_HOST"
)
