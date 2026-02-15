#!/bin/bash

# --- USER CONFIGURATION ---
# The username on your public-facing server (jump host)
REMOTE_USER="jumper"

# The domain or IP address of your public-facing server (jump host)
REMOTE_HOST="chd-extractor.cz"

# The port on your public-facing server to be forwarded back to the client's port 22.
# This must be a unique port for each client PC.
REMOTE_PORT="2223"

# The local port on the client machine to be forwarded.
# This is typically the default SSH port, 22.
LOCAL_PORT="22"

# The path to the SSH private key for authentication.
# This key should be generated without a passphrase for non-interactive use.
# It MUST be copied to the remote server's authorized_keys file.
SSH_KEY_PATH="/home/spedquick/.ssh/aipc_tunnel"

# --- AUTOSSH CONFIGURATION ---
# -M 0 : Disable monitoring port, use SSH connection itself for monitoring.
# -N   : Do not execute a remote command, just forward ports.
# -o   : Options passed to ssh.
#   ServerAliveInterval 60: Send a keep-alive message every 60 seconds.
#   ServerAliveCountMax 3: Disconnect after 3 failed keep-alive messages.
#   ExitOnForwardFailure yes: Exit if the port forwarding fails.

# --- DO NOT EDIT BELOW THIS LINE ---

echo "Starting autossh to create reverse tunnel..."

# The core autossh command
autossh -M 0 -N \
  -o "ServerAliveInterval 60" \
  -o "ServerAliveCountMax 3" \
  -o "ExitOnForwardFailure yes" \
  -i "$SSH_KEY_PATH" \
  -R "$REMOTE_PORT:localhost:$LOCAL_PORT" \
  "$REMOTE_USER@$REMOTE_HOST"

echo "autossh process terminated."

exit 0
