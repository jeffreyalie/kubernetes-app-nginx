# manual

## Docker
1. Docker build
```bash
docker build -t 10.206.213.243:32000/kubernetes-app-nginx:v1  ./app
```

2. Docker run
```bash
docker run -d --name kubernetes-app-nginx --restart unless-stopped -p 8080:80  10.206.213.243:32000/kubernetes-app-nginx:v1
```

3. change version
```bash
docker run -d --name kubernetes-app-nginx --restart unless-stopped -p 8080:80  10.206.213.243:32000/kubernetes-app-nginx:v2
```
4. stop and remove old 
```bash
docker stop kubernetes-app-nginx
docker rm kubernetes-app-nginx
```

5. run new version
```bash
docker run -d --name kubernetes-app-nginx --restart unless-stopped -p 8080:80  10.206.213.243:32000/kubernetes-app-nginx:v1
```

## Helm

1. 