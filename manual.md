# manual

## Docker
1. Docker build
```bash
docker build -t harbor.local/microk8s/kubernetes-app-nginx:v1  ./app
```

2. Docker run
```bash
docker run -d --name kubernetes-app-nginx --restart unless-stopped -p 8080:80  harbor.local/microk8s/kubernetes-app-nginx:v1
```

3. stop and remove old 
```bash
docker stop kubernetes-app-nginx
docker rm kubernetes-app-nginx
```

4. run new version
```bash
docker run -d --name kubernetes-app-nginx --restart unless-stopped -p 8080:80  harbor.local/microk8s/kubernetes-app-nginx:v2
```

## Helm

1. Install

```bash
helm upgrade --install kubernetes-app-nginx ./helm/kubernetes-app-nginx \
  --namespace dev \
  --create-namespace
```

2. To roll out a new image tag at the same time:

```bash
helm upgrade --install kubernetes-app-nginx ./helm/kubernetes-app-nginx \
  --namespace dev \
  --create-namespace \
  --set image.tag=v2 \
  --wait --timeout 2m
```
3. Then verify:

```bash
kubectl rollout status deployment/kubernetes-app-nginx -n dev
helm list -n dev
```