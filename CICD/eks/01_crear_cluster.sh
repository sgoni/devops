#!/bin/bash

# Script para crear un clúster EKS con eksctl

eksctl create cluster \
  --name eks-mundos-e \
  --region us-east-1 \
  --node-type t3.small \
  --nodes 3 \
  --with-oidc \
  --ssh-access \
  --ssh-public-key ec2-pin-key \
  --managed \
  --full-ecr-access \
  --zones us-east-1a,us-east-1b,us-east-1c

aws eks update-kubeconfig --name eks-mundos-e

echo "Clúster EKS creado exitosamente."