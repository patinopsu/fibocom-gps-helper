#!/bin/bash

for i in {1..60}; do
    MODEM_PATH=$(mmcli -L 2>/dev/null | grep -o '/org/freedesktop/ModemManager1/Modem/[0-9]*' | tail -n1)
    if [ -n "$MODEM_PATH" ]; then
	echo "[INFO] Enabling GPS..."
        echo "Modem found at $MODEM_PATH"
        mmcli -m "$MODEM_PATH" --location-enable-gps-nmea --location-enable-gps-raw
        exit 0
    else
        echo "Modem not found, waiting..."
        sleep 1
    fi
done

echo "Modem not found after 60 seconds. Giving up."
exit 1
