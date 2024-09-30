#!/bin/bash

# Desinstalar Prometheus

echo "Deteniendo el proceso de Prometheus..."

# Buscar el proceso de Prometheus
PROMETHEUS_PID=$(pgrep prometheus)

# Si se encuentra el proceso, detenerlo
if [ -n "$PROMETHEUS_PID" ]; then
    echo "Se encontró Prometheus corriendo con PID: $PROMETHEUS_PID"
    kill $PROMETHEUS_PID
    echo "Proceso Prometheus detenido."
else
    echo "No se encontró ningún proceso de Prometheus corriendo."
fi

# Eliminar los binarios
echo "Eliminando binarios de Prometheus..."
sudo rm -f /usr/local/bin/prometheus
sudo rm -f /usr/local/bin/promtool
echo "Binarios eliminados."

# Eliminar archivos de configuración y datos
echo "Eliminando archivos de configuración y datos..."
sudo rm -rf /etc/prometheus
sudo rm -rf /var/lib/prometheus
echo "Archivos de configuración y datos eliminados."

# Eliminar el archivo de servicio de systemd, si existe
if [ -f /etc/systemd/system/prometheus.service ]; then
    echo "Eliminando el archivo de servicio de Prometheus..."
    sudo rm -f /etc/systemd/system/prometheus.service
    sudo systemctl daemon-reload
    echo "Archivo de servicio eliminado y systemd recargado."
else
    echo "No se encontró un archivo de servicio de Prometheus en systemd."
fi

# Eliminar los archivos descargados
echo "Eliminando archivos descargados de Prometheus..."
rm -f prometheus-*.linux-amd64.tar.gz
rm -rf prometheus-*.linux-amd64
echo "Archivos descargados eliminados."

echo "Desinstalación de Prometheus completada."