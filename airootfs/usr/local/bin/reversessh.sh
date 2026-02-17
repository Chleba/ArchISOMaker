#!/bin/bash

# load dynamic port config 
CONFIG_FILE="/home/chdata/.config/tunnel_config"
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "config not found - ending"
    exit 1
fi

REMOTE_USER="jumper"
REMOTE_HOST="chd-extractor.cz"
LOCAL_PORT="22"
SSH_KEY_PATH="/home/chdata/.ssh/aipc_tunnel"

echo "Starting autossh with port $REMOTE_PORT..."

autossh -M 0 -N \
  -o "ServerAliveInterval 60" \
  -o "ServerAliveCountMax 3" \
  -o "ExitOnForwardFailure yes" \
  -i "$SSH_KEY_PATH" \
  -R "$REMOTE_PORT:localhost:$LOCAL_PORT" \
  "$REMOTE_USER@$REMOTE_HOST"

echo "autossh process terminated."

exit 0

