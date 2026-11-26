# MicroK8s / Kubernetes: Managing Application Files with Helm

**Best suited to:** reproducible CI/CD deployments and application releases.

The HTML file is packaged into the container image during the image build. Kubernetes runs a Pod using that image.

### Deployment workflow

```text
Ubuntu source code (index.html)
          |
          v
Dockerfile COPY -> Build image
          |
          v
Push image to MicroK8s registry
          |
          v
Helm deploys/updates Kubernetes Deployment
          |
          v
Pod runs Nginx with the packaged HTML
```

### Directory structure

```text
kubernetes-app-nginx/
├── app/
│   ├── Dockerfile
│   └── index.html
└── helm/
    └── kubernetes-app-nginx/
        ├── Chart.yaml
        ├── values.yaml
        └── templates/
            ├── deployment.yaml
            └── service.yaml
```
## Prerequisite
**MicroK8s level secrests***
Used by container to pull image from harbor. settings via deployment.yaml
```bash
      imagePullSecrets:
        - name: harbor-pull   
```
```bash
for NS in dev staging live; do
  microk8s kubectl create secret docker-registry harbor-pull \
    --docker-server=harbor.local \
    --docker-username='robot$microk8s+microk8s' \
    --docker-password='EdWc3ihTH1uKvaJ5TNmQsX6pJaOrZAvZ' \
    -n $NS --dry-run=client -o yaml | microk8s kubectl apply -f -
done
```
### app/Dockerfile

```dockerfile
FROM nginx:latest

COPY index.html /usr/share/nginx/html/index.html
```

`COPY` adds the host file to the image at build time.

### Build and push the image

This example uses the MicroK8s registry at `harbor.local`:

```bash
docker build \
  -t harbor.local/microk8s/kubernetes-app-nginx:v1 \
  ./app

docker push harbor.local/microk8s/kubernetes-app-nginx:v1
```

## Useful MicroK8s commands

| Command | Purpose |
|---|---|
| `microk8s kubectl get pods -n dev` | List Pods |
| `microk8s kubectl get deployments -n dev` | List Deployments |
| `microk8s kubectl get services -n dev` | List Services |
| `microk8s kubectl get configmaps -n dev` | List ConfigMaps |
| `microk8s kubectl describe pod POD -n dev` | Inspect a Pod |
| `microk8s kubectl logs POD -n dev` | View Pod logs |
| `microk8s kubectl exec -it POD -n dev -- bash` | Open a shell, if Bash is installed |
| `microk8s kubectl cp` | Copy files to/from a Pod |
| `microk8s kubectl rollout status deployment/NAME -n dev` | Check rollout status |
| `microk8s kubectl rollout history deployment/NAME -n dev` | View rollout history |
| `microk8s helm3 list -n dev` | List Helm releases |
| `microk8s helm3 upgrade` | Upgrade a Helm release |
| `microk8s helm3 rollback` | Roll back a Helm release |

---