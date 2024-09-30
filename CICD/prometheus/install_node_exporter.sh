#!/bin/bash

# Instalación automática de Node Exporter en Ubuntu

# Variables
NODE_EXPORTER_VERSION="1.6.1"
NODE_EXPORTER_USER="node_exporter"
NODE_EXPORTER_BIN_DIR="/usr/local/bin"
NODE_EXPORTER_SERVICE_FILE="/etc/systemd/system/node_exporter.service"

# Actualizar repositorios
echo "Actualizando repositorios..."
sudo apt update && sudo apt upgrade -y

# Crear usuario node_exporter
echo "Creando usuario node_exporter..."
sudo useradd --no-create-home --shell /bin/false $NODE_EXPORTER_USER

# Descargar Node Exporter
echo "Descargando Node Exporter versión $NODE_EXPORTER_VERSION..."
wget https://github.com/prometheus/node_exporter/releases/download/v$NODE_EXPORTER_VERSION/node_exporter-$NODE_EXPORTER_VERSION.linux-amd64.tar.gz

# Extraer archivos descargados
echo "Extrayendo archivos..."
tar -xvf node_exporter-$NODE_EXPORTER_VERSION.linux-amd64.tar.gz

# Mover binario a /usr/local/bin
echo "Moviendo binario de Node Exporter..."
sudo mv node_exporter-$NODE_EXPORTER_VERSION.linux-amd64/node_exporter $NODE_EXPORTER_BIN_DIR/

# Cambiar permisos del binario
echo "Cambiando permisos del binario..."
sudo chown $NODE_EXPORTER_USER:$NODE_EXPORTER_USER $NODE_EXPORTER_BIN_DIR/node_exporter

# Crear archivo de servicio systemd
if [ -f "$NODE_EXPORTER_SERVICE_FILE" ]; then
  echo "Archivo de servicio ya existe, sobrescribiendo..."
fi

echo "Creando archivo de servicio systemd para Node Exporter..."
sudo bash -c "cat > $NODE_EXPORTER_SERVICE_FILE" <<EOL
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=$NODE_EXPORTER_USER
Group=$NODE_EXPORTER_USER
Type=simple
ExecStart=$NODE_EXPORTER_BIN_DIR/node_exporter

[Install]
WantedBy=multi-user.target
EOL

# Recargar demonio systemd y habilitar Node Exporter
echo "Recargando systemd y habilitando Node Exporter..."
sudo systemctl daemon-reload
sudo systemctl enable node_exporter

# Iniciar servicio de Node Exporter
echo "Iniciando servicio de Node Exporter..."
sudo systemctl start node_exporter

# Limpiar archivos descargados
echo "Limpiando archivos temporales..."
rm -rf node_exporter-$NODE_EXPORTER_VERSION.linux-amd64 node_exporter-$NODE_EXPORTER_VERSION.linux-amd64.tar.gz

echo "Instalación de Node Exporter completada."
echo "Puedes verificar el estado del servicio con: sudo systemctl status node_exporter"
echo "Accede a las métricas de Node Exporter en: http://localhost:9100/metrics"