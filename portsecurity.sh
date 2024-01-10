#!/bin/bash
ufw allow 22
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 20
ufw allow 4200/tcp
ufw allow 8080/tcp

ufw enable

ufw verbose
