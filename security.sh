#!/bin/bash

LOG_FILE="/var/log/auth.log"

login_info=$(grep -E "sshd|CRON|pam_unix" "$LOG_FILE")

echo "----- Últimos Inicios de Sesión y Seguridad -----"
echo "$login_info"
echo "-----------------------------------------------"

