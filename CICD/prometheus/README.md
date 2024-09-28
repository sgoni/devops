# Instalación de Prometheus

## Table of Contents
1. [General Info](#general-info)
2. [Requirements](#requirements)
3. [Installation](#installation)
4. [Consideraciones Especiales para WSL](#consideraciones-especiales-para-wsl)
5. [Instalar Node Exporter Linux](#instalar-node-exporter-linux)
6. [Author](#author)
7. [License](#license)
8. [FAQs](#faqs)
   
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