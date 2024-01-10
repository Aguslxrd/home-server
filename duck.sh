##duckdns config script
echo url="https://www.duckdns.org/update?domains=dominioaqui&token=token&ip=" | curl -k -o ~/duckdns/duck.log -K -
