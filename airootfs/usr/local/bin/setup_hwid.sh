#!/bin/bash

CONFIG_DIR="/home/chdata/.config/hw_info"
mkdir -p "$CONFIG_DIR"

BOARD_SERIAL=$(cat /sys/class/dmi/id/board_serial 2>/dev/null || echo "unknown_serial")
PRODUCT_UUID=$(cat /sys/class/dmi/id/product_uuid 2>/dev/null || echo "unknown_uuid")

HW_HASH=$(echo -n "${BOARD_SERIAL}${PRODUCT_UUID}" | sha256sum | awk '{print $1}')

echo "$BOARD_SERIAL" > "$CONFIG_DIR/board_serial"
echo "$PRODUCT_UUID" > "$CONFIG_DIR/product_uuid"
echo "$HW_HASH" > "$CONFIG_DIR/hw_id_hash"

chown -R chdata:chdata /home/chdata/.config
chmod 444 "$CONFIG_DIR/board_serial" "$CONFIG_DIR/product_uuid" "$CONFIG_DIR/hw_id_hash"

