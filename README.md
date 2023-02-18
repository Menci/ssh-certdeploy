# SSH CertDeploy

Deploy certificate to servers with SSH.

* Restrict SSH key's usage to cert deploy
* Verify host key

## Usage

Clone this repo to somewhere (e.g. `/opt/ssh-certdeploy`). Generate an SSH key for deploying. Add the public key to the server's `/root/.ssh/authorized_keys`:

```
command="/opt/ssh-certdeploy/receive-cert.sh example",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-ed25519 <your-ssh-key-content....>
```

The example stands for the `config.example.sh` configuration file. It's an example that print the deployed certificate and key file to stdout. Create a new configuration file and change the command above.

```bash
CERT_FILE="/etc/nginx/ssl/ssl.crt"
KEY_FILE="/etc/nginx/ssl/ssl.key"
RELOAD_CMD="systemctl reload nginx"
```

To deploy the certificate in your automated workflow, run `send-cert.sh`:

```bash
# Get host key of the server
grep your-host.domain.tld ~/.ssh/known_hosts > known_hosts_for_server

# Put file content of `known_hosts_for_server` to your workflow's environment
# Also put your SSH key's private key file on it
./send-cert.sh \
    root@your-host.domain.tld 22 \
    "$KNOWN_HOSTS_FOR_SERVER" \
    deploy-key/id_ed25519_certdeploy \
    ssl.crt ssl.key
```
