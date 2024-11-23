#!/bin/bash

# Limpiar contenedores existentes
docker-compose down

# Subir el stack
docker-compose up -d

# Verificar logs
docker logs -f graylog
