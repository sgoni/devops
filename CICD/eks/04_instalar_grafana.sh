#!/bin/bash

# Script para la instalación de Grafana en Kubernetes utilizando Helm

# Crear el namespace para Grafana
echo "Creando el namespace grafana..."
kubectl create namespace grafana

# Verificar si el namespace fue creado exitosamente
if kubectl get namespace | grep -q grafana; then
  echo "Namespace 'grafana' creado con éxito."
else
  echo "Error al crear el namespace 'grafana'."
  exit 1
fi

# Agregar el repositorio de Helm para Grafana
echo "Agregando el repositorio de Helm para Grafana..."
helm repo add grafana https://grafana.github.io/helm-charts

# Actualizar los repositorios de Helm para obtener la última versión de Grafana
echo "Actualizando los repositorios de Helm..."
helm repo update

# Instalar Grafana en el namespace grafana con las configuraciones especificadas
echo "Instalando Grafana con Helm..."
helm install grafana grafana/grafana \
  --namespace grafana \
  --set persistence.storageClassName="gp2" \
  --set persistence.enabled=true \
  --set adminPassword='EKS!sAWSome' \
  --values ${HOME}/environment/grafana/grafana.yaml \
  --set service.type=LoadBalancer

# Verificar si la instalación de Grafana fue exitosa
if helm list -n grafana | grep -q grafana; then
  echo "Grafana instalado con éxito en el namespace grafana."
else
  echo "Error al instalar Grafana."
  exit 1
fi

# Mostrar todos los recursos creados en el namespace grafana
echo "Listando los recursos en el namespace grafana:"
kubectl get all -n grafana
