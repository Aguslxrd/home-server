#!/bin/bash

block_ip() {
    read -p "Ingrese la dirección IP que desea bloquear: " IP
    iptables -A INPUT -s $IP -j DROP
    iptables -A OUTPUT -d $IP -j DROP
    service iptables save
    echo "La dirección IP $IP ha sido bloqueada."
}

unblock_ip() {
    read -p "Ingrese la dirección IP que desea desbloquear: " IP
    iptables -D INPUT -s $IP -j DROP
    iptables -D OUTPUT -d $IP -j DROP
    service iptables save
    echo "La dirección IP $IP ha sido desbloqueada."
}

list_blocked_ips() {
    echo "Direcciones IP bloqueadas:"
    iptables -L INPUT -v -n | awk '$1=="DROP" { print $8 }'
}

save_blocked_ips() {
    iptables -L INPUT -v -n | awk '$1=="DROP" { print $8 }' > ips_bloqueadas.txt
    echo "Las direcciones IP bloqueadas se han guardado en el archivo ips_bloqueadas.txt"
}

block_country_ips() {
    read -p "Ingrese el código de país que desea bloquear (ISO CODE, UY, ARG): " COUNTRY
    IP_LIST=$(wget -qO- https://www.ip2location.com/free/visitor-blocker/$COUNTRY | awk -F'[,]' '{ print $2 }' | tr -d '"' | sort -u)

    for IP in $IP_LIST; do
        iptables -A INPUT -s $IP -j DROP
        iptables -A OUTPUT -d $IP -j DROP
    done

    service iptables save
    echo "Se han bloqueado todas las direcciones IP del país $COUNTRY."
}

while true; do
    echo "Seleccione una opción:"
    echo "1. Bloquear una dirección IP"
    echo "2. Desbloquear una dirección IP"
    echo "3. Mostrar las direcciones IP bloqueadas"
    echo "4. Guardar las direcciones IP bloqueadas en un archivo de texto"
    echo "5. Bloquear las direcciones IP de un país"
    echo "6. Salir"
    read -p "Ingrese su selección: " option

    case $option in
        1) block_ip ;;
        2) unblock_ip ;;
        3) list_blocked_ips ;;
        4) save_blocked_ips ;;
        5) block_country_ips ;;
        6) exit ;;
        *) echo "Opción inválida." ;;
    esac
done