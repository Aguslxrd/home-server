#!/bin/bash

##lista de ips/list of ips.
ip_addresses=(
    "xxx.xxx.xx.x"
	"xxx.xxx.xx.x"
	"xxx.xxx.xx.x"
)

for ip in "${ip_addresses[@]}"; do
    route add -host "$ip" reject
done

echo "Reglas de rechazo agregadas exitosamente."

