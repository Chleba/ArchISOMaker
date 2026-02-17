#!/bin/bash

CONFIG_FILE="/home/chdata/.config/tunnel_config"
FLAG_FILE="/home/chdata/.config/.setup_done"

if [ ! -f "$FLAG_FILE" ]; then
    # generating ssh key for tunneling
    mkdir -p /home/chdata/.ssh
    ssh-keygen -t ed25519 -N "" -f /home/chdata/.ssh/aipc_tunnel
    chown -R chdata:chdata /home/chdata/.ssh

    # load hw fingerprints
    BOARD_SERIAL=$(cat /home/chdata/.config/hw_info/board_serial)
    PRODUCT_UUID=$(cat /home/chdata/.config/hw_info/product_uuid)
    PUB_KEY=$(cat /home/chdata/.ssh/aipc_tunnel.pub)

    # 3. Odeslání na server a získání portu (předpokládá se API vracící port)
    # Server by měl vrátit pouze číslo portu (např. 2223)
    REMOTE_PORT=$(curl -s -X POST \
        -d "serial=$BOARD_SERIAL" \
        -d "uuid=$PRODUCT_UUID" \
        -d "pubkey=$PUB_KEY" \
        https://chd-extractor.cz/hw/register)

    # save configuration
    echo "REMOTE_PORT=\"$REMOTE_PORT\"" > "$CONFIG_FILE"
    echo "BOARD_SERIAL=\"$BOARD_SERIAL\"" >> "$CONFIG_FILE"
    echo "PRODUCT_UUID=\"$PRODUCT_UUID\"" >> "$CONFIG_FILE"
    chown chdata:chdata "$CONFIG_FILE"

    touch "$FLAG_FILE"
fi
