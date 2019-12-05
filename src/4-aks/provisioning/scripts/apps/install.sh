helm upgrade clippy ./clippy --install 

kubectl apply -f http-ingress.yaml
kubectl apply -f http-ingress.clean.yaml
kubectl apply -f podinfo-deployment.yaml

az aks get-credentials -g matrix-dev-k8s -n matrix-aks-dev

curl http://resultaatgroep.cf