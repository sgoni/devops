#!/bin/bash

# Script para limpiar los recursos de Prometheus, Grafana y el clúster EKS

# Desinstalar Prometheus y eliminar el namespace prometheus
echo "Desinstalando Prometheus..."
helm uninstall prometheus --namespace prometheus

# Verificar si Prometheus fue desinstalado correctamente
if ! helm list -n prometheus | grep -q prometheus; then
  echo "Prometheus desinstalado con éxito."
else
  echo "Error al desinstalar Prometheus."
fi

echo "Eliminando el namespace prometheus..."
kubectl delete ns prometheus

# Verificar si el namespace prometheus fue eliminado
if ! kubectl get ns | grep -q prometheus; then
  echo "Namespace 'prometheus' eliminado con éxito."
else
  echo "Error al eliminar el namespace 'prometheus'."
fi

# Desinstalar Grafana y eliminar el namespace grafana
echo "Desinstalando Grafana..."
helm uninstall grafana --namespace grafana

# Verificar si Grafana fue desinstalado correctamente
if ! helm list -n grafana | grep -q grafana; then
  echo "Grafana desinstalado con éxito."
else
  echo "Error al desinstalar Grafana."
fi

echo "Eliminando el namespace grafana..."
kubectl delete ns grafana

# Verificar si el namespace grafana fue eliminado
if ! kubectl get ns | grep -q grafana; then
  echo "Namespace 'grafana' eliminado con éxito."
else
  echo "Error al eliminar el namespace 'grafana'."
fi

# Eliminar el clúster EKS
echo "Eliminando el clúster EKS 'eks-mundos-e'..."
eksctl delete cluster --name eks-mundos-e

# Verificar si el clúster fue eliminado correctamente
if ! eksctl get cluster | grep -q eks-mundos-e; then
  echo "Clúster 'eks-mundos-e' eliminado con éxito."
else
  echo "Error al eliminar el clúster 'eks-mundos-e'."
fi

echo "Limpieza de recursos completada."
