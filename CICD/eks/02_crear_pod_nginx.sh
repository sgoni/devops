#!/bin/bash

# Script para crear un pod de Nginx y exponerlo como un servicio en Kubernetes

# Crear el deployment de Nginx
echo "Creando el deployment de Nginx..."
kubectl create deployment nginx1 --image=nginx

# Verificar si el deployment fue creado exitosamente
if kubectl get deployments | grep -q nginx1; then
  echo "Deployment nginx1 creado con éxito."
else
  echo "Error al crear el deployment nginx1."
  exit 1
fi

# Exponer el deployment como un servicio de tipo LoadBalancer
echo "Exponiendo el servicio mundose-web en el puerto 80..."
kubectl expose deployment nginx1 --port=80 --name=mundose-web --type=LoadBalancer

# Verificar si el servicio fue creado exitosamente
if kubectl get svc | grep -q mundose-web; then
  echo "Servicio mundose-web expuesto con éxito."
else
  echo "Error al exponer el servicio mundose-web."
  exit 1
fi

# Mostrar los servicios actuales
echo "Listando los servicios activos:"
kubectl get svc