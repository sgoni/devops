#!/bin/bash

# Instalación automática de Prometheus en Ubuntu o WSL

# Variables
PROM_VERSION="2.49.0"
PROM_USER="prometheus"
PROM_DIR="/etc/prometheus"
PROM_DATA_DIR="/var/lib/prometheus"
PROM_BIN_DIR="/usr/local/bin"
PROM_SERVICE_FILE="/etc/systemd/system/prometheus.service"

# Actualizar repositorios
echo "Actualizando repositorios..."
sudo apt update && sudo apt upgrade -y

# Crear usuario prometheus
echo "Creando usuario prometheus..."
sudo useradd --no-create-home --shell /bin/false $PROM_USER

# Crear directorios necesarios
echo "Creando directorios..."
sudo mkdir -p $PROM_DIR $PROM_DATA_DIR

# Descargar Prometheus
echo "Descargando Prometheus versión $PROM_VERSION..."
wget https://github.com/prometheus/prometheus/releases/download/v$PROM_VERSION/prometheus-$PROM_VERSION.linux-amd64.tar.gz

# Extraer archivos descargados
echo "Extrayendo archivos..."
tar -xvf prometheus-$PROM_VERSION.linux-amd64.tar.gz

# Mover binarios a /usr/local/bin
echo "Moviendo binarios..."
sudo mv prometheus-$PROM_VERSION.linux-amd64/prometheus $PROM_BIN_DIR/
sudo mv prometheus-$PROM_VERSION.linux-amd64/promtool $PROM_BIN_DIR/

# Mover archivos de configuración
echo "Moviendo archivos de configuración..."
sudo mv prometheus-$PROM_VERSION.linux-amd64/consoles $PROM_DIR/
sudo mv prometheus-$PROM_VERSION.linux-amd64/console_libraries $PROM_DIR/
sudo mv prometheus-$PROM_VERSION.linux-amd64/prometheus.yml $PROM_DIR/

# Cambiar permisos de los directorios
echo "Cambiando permisos..."
sudo chown -R $PROM_USER:$PROM_USER $PROM_DIR $PROM_DATA_DIR

# Crear archivo de servicio systemd
if [ -f "$PROM_SERVICE_FILE" ]; then
  echo "Archivo de servicio ya existe, sobrescribiendo..."
fi

echo "Creando archivo de servicio systemd para Prometheus..."
sudo bash -c "cat > $PROM_SERVICE_FILE" <<EOL
[Unit]
Description=Prometheus Monitoring
Wants=network-online.target
After=network-online.target

[Service]
User=$PROM_USER
Group=$PROM_USER
Type=simple
ExecStart=$PROM_BIN_DIR/prometheus \
  --config.file=$PROM_DIR/prometheus.yml \
  --storage.tsdb.path=$PROM_DATA_DIR \
  --web.console.templates=$PROM_DIR/consoles \
  --web.console.libraries=$PROM_DIR/console_libraries

[Install]
WantedBy=multi-user.target
EOL

# Recargar demonio systemd y habilitar Prometheus
echo "Recargando systemd y habilitando Prometheus..."
sudo systemctl daemon-reload
sudo systemctl enable prometheus

# Iniciar servicio de Prometheus
echo "Iniciando servicio de Prometheus..."
sudo systemctl start prometheus

# Limpiar archivos descargados
echo "Limpiando archivos temporales..."
rm -rf prometheus-$PROM_VERSION.linux-amd64 prometheus-$PROM_VERSION.linux-amd64.tar.gz

echo "Instalación de Prometheus completada."
echo "Puedes verificar el estado del servicio con: sudo systemctl status prometheus"
echo "Accede a Prometheus en: http://localhost:9090"
