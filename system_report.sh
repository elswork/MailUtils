#!/bin/bash

# Script para generar un reporte del estado del sistema.

echo "--- Reporte del Sistema ---"
echo "Fecha: $(date)"
echo ""

echo "--- 1. Información del Host ---"
echo "Hostname: $(hostname)"
if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "Distribución: $PRETTY_NAME"
fi
echo "Kernel: $(uname -r)"
echo ""

echo "--- 2. Uptime y Carga del Sistema ---"
uptime
echo ""

echo "--- 3. Uso de Disco ---"
df -h
echo ""

echo "--- 4. Uso de Memoria ---"
free -h
echo ""

echo "--- 5. Información de Red ---"
# Usamos 'curl' para obtener la IP pública. El contenedor debe tenerlo o la máquina host.
# El comando 'ip' muestra las IPs locales.
echo "IP Pública: $(curl -s ifconfig.me || echo 'No se pudo obtener')"
echo "IPs Locales:"
ip -4 addr show | grep -oP 'inet \K[\d.]+'
echo ""

echo "--- 6. Procesos con Mayor Consumo (Top 5) ---"
echo "Por CPU:"
ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -n 6
echo ""
echo "Por Memoria:"
ps -eo pid,user,%cpu,%mem,comm --sort=-%mem | head -n 6
echo ""

echo "--- Fin del Reporte ---"
