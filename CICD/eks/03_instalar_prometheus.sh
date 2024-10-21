#!/bin/bash

# Script para la instalación de Prometheus en Kubernetes utilizando Helm

# Crear el namespace para Prometheus
echo "Creando el namespace prometheus..."
kubectl create namespace prometheus

# Instalar driver EBS CSI
echo "Instalando driver EBS CSI..."l
kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/ecr/?ref=release-1.36"

# Verificar si el namespace fue creado exitosamente
if kubectl get namespace | grep -q prometheus; then
  echo "Namespace 'prometheus' creado con éxito."
else
  echo "Error al crear el namespace 'prometheus'."
  exit 1
fi

# Agregar el repositorio de Prometheus
echo "Agregando el repositorio de Helm para Prometheus..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

# Actualizar los repositorios de Helm para obtener la última versión disponible
echo "Actualizando los repositorios de Helm..."
helm repo update

# Instalar Prometheus en el namespace prometheus
echo "Instalando Prometheus con Helm..."
helm install prometheus prometheus-community/prometheus \
  --namespace prometheus \
  --set alertmanager.persistentVolume.storageClass="gp2" \
  --set server.persistentVolume.storageClass="gp2"

# Aplicar script pv.yaml
echo "Aplicandp script pv.yaml..."
sudo kubectl apply -f pv.yaml

# Verificar si la instalación fue exitosa
if helm list -n prometheus | grep -q prometheus; then
  echo "Prometheus instalado con éxito en el namespace prometheus."
else
  echo "Error al instalar Prometheus."
  exit 1
fi

# Mostrar los recursos creados en el namespace prometheus
echo "Mostrando los recursos en el namespace prometheus:"
kubectl get all -n prometheus
