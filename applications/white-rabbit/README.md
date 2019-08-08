
# Observability demos - White-rabbit

## Build

### pre-requisites running on Minikube

```
eval $(minikube docker-env)
```

### server

```
cd server-app
docker build . -t white-rabbit/server-app:latest
cd -
```

### client

```
cd client-app-java
docker build . -t white-rabbit/client-app-java:latest
cd -
```

---

## Deploy

### Applications

```
kubectl apply -f kube/namespace.yaml
kubectl apply -f kube/postgresql
kubectl apply -f kube/server-app
kubectl apply -f kube/client-app
kubectl apply -f kube/grafana-update
```

`OPTIONAL if running on Minikube`
```
kubectl apply -f kube/ingress
kubectl delete pod -l app.kubernetes.io/name=nginx-ingress-controller
```

---

## API calls

* Prepare env-vars
	```
	WHITE_RABBIT_HOST=$(minikube ip)
	WHITE_RABBIT_PORT=$(kubectl get svc -n white-rabbit | grep -i client-app | awk '{print $5}' | cut -d ',' -f 1 | sed 's,[0-9]*:,,' | sed 's,/TCP,,')
	```
* Insert
	```
	http POST $WHITE_RABBIT_HOST:$WHITE_RABBIT_PORT/users email="matteo.baiguini@rabbit.com" name="Matteo Baiguini" age=33
	http POST $WHITE_RABBIT_HOST:$WHITE_RABBIT_PORT/users email="john.doe@rabbit.com" name="John Doe" age=42
	http POST $WHITE_RABBIT_HOST:$WHITE_RABBIT_PORT/users email="jane.doe@rabbit.com" name="Jane Doe" age=24
	http POST $WHITE_RABBIT_HOST:$WHITE_RABBIT_PORT/users email="clint.eastwood@rabbit.com" name="Clint Eastwood" age=75
	```
* Get
	```
	http $WHITE_RABBIT_HOST:$WHITE_RABBIT_PORT/users
	http $WHITE_RABBIT_HOST:$WHITE_RABBIT_PORT/users/matteo.baiguini@rabbit.com
	```
* Update
	```
	USER_ID=$(http $WHITE_RABBIT_HOST:$WHITE_RABBIT_PORT/users/clint.eastwood@rabbit.com | jq ".id")
	http PUT $WHITE_RABBIT_HOST:$WHITE_RABBIT_PORT/users id=$USER_ID email="clint.eastwood@rabbit.com" name="Clint Eastwood" age=89
	```
* Delete
	```
	http DELETE $WHITE_RABBIT_HOST:$WHITE_RABBIT_PORT/users/jane.doe@rabbit.com
	http DELETE $WHITE_RABBIT_HOST:$WHITE_RABBIT_PORT/users
	```
