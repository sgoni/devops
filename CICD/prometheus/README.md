# Instalación de Prometheus

## Table of Contents
1. [General Info](#general-info)
2. [Requirements](#requirements)
3. [Installation](#installation)
4. [Consideraciones Especiales para WSL](#consideraciones-especiales-para-wsl)
5. [Installation Script Bash](#installation-script-bash)
6. [Uninstallation](#uninstallation)
7. [Instalar Node Exporter Linux](#instalar-node-exporter-linux)
8. [Script Bash para Instalar Node Exporter](#script_bash_para_instalar_node_exporter)
9. [Author](#author)
10. [License](#license)
   
### General Info
   
Sigue los siguientes pasos para instalar Prometheus en tu sistema.

### Requirements
|Platform|Language|IDE|
|:----------:|:--------:|:---:|
[Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)||![Windows Terminal](https://img.shields.io/badge/Windows%20Terminal-%234D4D4D.svg?style=for-the-badge&logo=windows-terminal&logoColor=white)|teacher don't h
![Prometheus](https://img.shields.io/badge/Prometheus-E6522C?style=for-the-badge&logo=Prometheus&logoColor=white)

## Installation
Ejecutar desde la terminal de consola con derechos de administrador los siguientes comandos.

### Paso 1: Actualiza los paquetes del sistema

```bash
sudo apt update
sudo apt upgrade -y
```

### Paso 2: Crea un usuario para Prometheus

```bash
sudo useradd --no-create-home --shell /bin/false prometheus
```

### Paso 3: Crea los directorios necesarios

```bash
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
```

### Paso 4: Descarga Prometheus

```bash
wget https://github.com/prometheus/prometheus/releases/download/v2.49.0/prometheus-2.49.0.linux-amd64.tar.gz
```

### Paso 5: Extrae los archivos descargados

```bash
tar -xvf prometheus-2.49.0.linux-amd64.tar.gz
```

### Paso 6: Mueve los archivos binarios a /usr/local/bin

```bash
cd prometheus-2.49.0.linux-amd64
sudo mv prometheus promtool /usr/local/bin/
```

### Paso 7: Mueve los archivos de configuración y establece permisos

```bash
sudo mv consoles/ console_libraries/ /etc/prometheus/
sudo mv prometheus.yml /etc/prometheus/
sudo chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus
```

```bash
sudo chown -R prometheus:prometheus /var/lib/prometheus/
sudo chmod -R 775 /var/lib/prometheus/
```

### Paso 8: Crea un archivo de servicio de Systemd

```bash
sudo vim /etc/systemd/system/prometheus.service
```

```bash
[Unit]
Description=Prometheus Monitoring
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
```

### Paso 9: Recarga Systemd y habilita Prometheus

```bash
sudo systemctl daemon-reload
sudo systemctl enable prometheus
```

### Paso 10: Inicia Prometheus

```bash
sudo systemctl start prometheus
```

### Paso 11: Verifica el estado de Prometheus

```bash
sudo systemctl status prometheus
```

### Paso 12: Accede a Prometheus

```arduino
http://localhost:9090
```

## Consideraciones Especiales para WSL

### 1- Acceso a los Servicios desde Windows:

    Al correr servicios en WSL, por defecto, estarán accesibles desde la máquina Windows utilizando localhost. Esto es útil para acceder a Prometheus directamente desde el navegador de Windows en http://localhost:9090.

### 2- Permisos de Systemd:

    WSL no soporta systemd de forma nativa, lo cual significa que los comandos relacionados con systemctl no funcionarán directamente. En lugar de usar systemctl para gestionar Prometheus, puedes iniciar Prometheus manualmente o crear un script que lo inicie cada vez que abras WSL.

#### Paso 1: Crear un Script de Inicio:

```bash
sudo vim start_prometheus.sh
```

```bash
#!/bin/bash
/usr/local/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/var/lib/prometheus --web.console.templates=/etc/prometheus/consoles --web.console.libraries=/etc/prometheus/console_libraries
```

#### Paso 2: Guarda el archivo y dale permisos de ejecución

```bash
chmod +x start_prometheus.sh
```

#### Paso 3: Inicia Prometheus usando el script:

```bash
./start_prometheus.sh
```
## Installation Script Bash

1- Dale permisos de ejecución al archivo install_prometheus.sh.

```bash
chmod +x install_prometheus.sh
```

2- Ejecuta el script con permisos de superusuario:

```bash
sudo ./install_prometheus.sh
```

## Uninstallation

1- Guarda el siguiente contenido en un archivo, por ejemplo, uninstall_prometheus.sh:

```bash
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
```

2- Dale permisos de ejecución al script:

```bash
chmod +x uninstall_prometheus.sh
```

3- Ejecutar el script:

```bash
sudo ./uninstall_prometheus.sh
```
## Instalar Node Exporter Linux

### Paso 1: Instalar las dependencias necesarias

```bash
apt update && apt install -y wget tar
```

### Paso 2: Descargar y extraer node_exporter

Cambiar al directorio de trabajo preferido y descargar el archivo node_exporter-1.8.2.linux-amd64.tar.gz.

```bash
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.2/node_exporter-1.8.2.linux-amd64.tar.gz
```

### Paso 3: Extrae el archivo descargado

```bash
tar xvf node_exporter-1.8.2.linux-amd64.tar.gz
```

### Paso 4: Mover y ejecutar node_exporter

```bash
mv node_exporter-1.8.2.linux-amd64/node_exporter /usr/local/bin/
chmod +x /usr/local/bin/node_exporter
```

### Paso 5: Ejecutar node_exporter

```bash
node_exporter &
```

### Paso 6: Verificar que node_exporter esté corriendo

Verificar si node_exporter está funcionando correctamente usando curl para acceder al puerto 9100:

```bash
apk add curl  # o `apt install -y curl` en Ubuntu
curl http://localhost:9100/metrics
```

## Script Bash para Instalar Node Exporter

Guarda el siguiente script como install_node_exporter.sh:

```bash
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
```

Dale permisos de ejecución al archivo:

```bash
chmod +x install_node_exporter.sh
```

Ejecuta el script con permisos de superusuario:

```bash
sudo ./install_node_exporter.sh
```
 
## Author

Steven Goni