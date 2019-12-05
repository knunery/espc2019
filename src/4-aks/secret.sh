kubectl create secret docker-registry romeimages --docker-server=https://romeimages.azurecr.io --docker-username=romeimages --docker-password=p/FMWvVuOIOlm9N1dt9ZfSQoglqbUprw --docker-email=pnaber@xpirit.com

kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

kubectl apply -f ingress.clean.yaml