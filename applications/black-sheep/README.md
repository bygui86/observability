
# Observability demos - Black-sheep

## Build

### pre-requisites running on Minikube

```
eval $(minikube docker-env)
```

### server

```
cd server-app
docker build . -t black-sheep/server-app:latest
cd -
```

### client

```
cd client-app-java
docker build . -t black-sheep/client-app-java:latest
cd -
```

---

## Deploy

### pre-requisites running on Minikube

```
[OPTIONAL] kubectl apply -f kube/nginx-ingress-controller.yaml
```

### applications

```
kubectl apply -f kube/namespace.yaml
kubectl apply -f kube/postgresql
kubectl apply -f kube/server-app
kubectl apply -f kube/client-app
[OPTIONAL] kubectl apply -f kube/ingress.yaml
```

---

## API calls

* Prepare env-vars
	```
	BLACK_SHEEP_HOST=$(minikube ip)
	BLACK_SHEEP_PORT=$(kubectl get svc -n black-sheep | grep -i client-app | awk '{print $5}' | cut -d ',' -f 1 | sed 's,[0-9]*:,,' | sed 's,/TCP,,')
	```
* Insert
	```
	http POST $BLACK_SHEEP_HOST:$BLACK_SHEEP_PORT/apis/users email="matteo.baiguini@rabbit.com" name="Matteo Baiguini" age=33
	http POST $BLACK_SHEEP_HOST:$BLACK_SHEEP_PORT/apis/users email="john.doe@rabbit.com" name="John Doe" age=42
	http POST $BLACK_SHEEP_HOST:$BLACK_SHEEP_PORT/apis/users email="jane.doe@rabbit.com" name="Jane Doe" age=24
	http POST $BLACK_SHEEP_HOST:$BLACK_SHEEP_PORT/apis/users email="clint.eastwood@rabbit.com" name="Clint Eastwood" age=75
	```
* Get
	```
	http $BLACK_SHEEP_HOST:$BLACK_SHEEP_PORT/apis/users
	http $BLACK_SHEEP_HOST:$BLACK_SHEEP_PORT/apis/users/matteo.baiguini@rabbit.com
	```
* Update
	```
	USER_ID=$(http $BLACK_SHEEP_HOST:$BLACK_SHEEP_PORT/apis/users/clint.eastwood@rabbit.com | jq ".id")
	http PUT $BLACK_SHEEP_HOST:$BLACK_SHEEP_PORT/apis/users id=$USER_ID email="clint.eastwood@rabbit.com" name="Clint Eastwood" age=89
	```
* Delete
	```
	http DELETE $BLACK_SHEEP_HOST:$BLACK_SHEEP_PORT/apis/users/jane.doe@rabbit.com
	http DELETE $BLACK_SHEEP_HOST:$BLACK_SHEEP_PORT/apis/users
	```
