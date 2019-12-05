# https://github.com/jetstack/cert-manager/issues/1255

kubectl apply -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.6/deploy/manifests/00-crds.yaml
kubectl create namespace cert-manager
kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true
helm repo add jetstack https://charts.jetstack.io
helm repo update

helm upgrade certmanager --install jetstack/cert-manager --namespace cert-manager --version v0.7.0 --set ingressShim.defaultIssuerName=letsencrypt-prod --set ingressShim.defaultIssuerKind=ClusterIssuer 

kubectl apply -f ClusterIssuerProduction.yaml

# --set ingressShim.defaultIssuerName=letsencrypt-prod --set ingressShim.defaultIssuerKind=ClusterIssuer



# kubectl delete clusterissuer letsencrypt-staging

# helm delete certmanager --purge