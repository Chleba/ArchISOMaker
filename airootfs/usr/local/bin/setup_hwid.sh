#!/bin/bash

mkdir -p /home/chdata/.config/hw_info
cat /sys/class/dmi/id/board_serial > /home/chdata/.config/hw_info/board_serial
cat /sys/class/dmi/id/product_uuid > /home/chdata/.config/hw_info/product_uuid

chown -R chdata:chdata /home/chdata/.config
chmod 444 /home/chdata/.config/hw_info/board_serial /home/chdata/.config/hw_info/product_uuid
