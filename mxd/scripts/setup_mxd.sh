#!/usr/bin/env bash
kind create cluster -n mxd --config /project/kind.config.yaml
kind export kubeconfig --name mxd
cp ~/.kube/config .
sed -i 's@https://127.0.0.1@https://mxd-control-plane@' ~/.kube/config
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s
kind load docker-image --name mxd data-service-api tx-identityhub tx-catalog-server tx-issuerservice
cd /project
terraform init
terraform apply --auto-approve