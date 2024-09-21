# For use when the router does not allowe setup of an additional TFP/Netboot server

BOOT_FILE
For netboot : "netboot.xyz.kpxe"
For pxe : "pxelinux.0" 

docker run -d --name dnsmasq \
  --net=host --cap-add=NET_ADMIN \
  -e RELAY_IP="192.168.1.1" \
  -e RELAY_LOCAL_IP="192.168.1.10" \
  -e DHCP_RANGE_START="192.168.1.100" \
  -e DHCP_RANGE_END="192.168.1.200" \
  -e TFTP_SERVER="192.168.1.50" \
  -e BOOT_FILE="netboot.xyz.kpxe" \
  -e INTERFACE="eth0" \
  -e LEASE_TIME="12h" \
  custom-dnsmasq
