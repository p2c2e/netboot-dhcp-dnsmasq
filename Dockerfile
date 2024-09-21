# Use an Alpine image with dnsmasq installed
FROM alpine:latest

# Install dnsmasq
RUN apk add --no-cache dnsmasq

# Copy the startup script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose necessary ports (53 for DNS, 67 for DHCP)
EXPOSE 53/udp 67/udp

# Run entrypoint to generate dnsmasq.conf and start dnsmasq
ENTRYPOINT ["/entrypoint.sh"]

