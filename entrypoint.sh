#!/bin/sh

# Set default values if not provided via environment variables
: "${RELAY_IP:=192.168.1.1}"
: "${RELAY_LOCAL_IP:=192.168.1.10}"
: "${DHCP_RANGE_START:=192.168.1.100}"
: "${DHCP_RANGE_END:=192.168.1.200}"
: "${TFTP_SERVER:=192.168.1.50}"
: "${BOOT_FILE:=pxelinux.0}"
: "${INTERFACE:=eth0}"
: "${LEASE_TIME:=12h}"

# Create the dnsmasq.conf file dynamically
cat <<EOF > /etc/dnsmasq.conf
# Enable DHCP proxy/relay mode
dhcp-relay=${RELAY_IP},${RELAY_LOCAL_IP}

# Set the network interface dnsmasq will listen on
interface=${INTERFACE}

# Advertise DHCP options including network boot IP
dhcp-range=${DHCP_RANGE_START},${DHCP_RANGE_END},${LEASE_TIME}
dhcp-boot=${BOOT_FILE},boothost,${TFTP_SERVER}

# Log all the DHCP and DNS activity (optional for debugging)
log-dhcp
log-queries

# Set additional DHCP options
dhcp-option=66,"${TFTP_SERVER}" # TFTP server
dhcp-option=67,"${BOOT_FILE}"   # Boot file name
EOF

# Run dnsmasq in the foreground
exec dnsmasq --no-daemon

