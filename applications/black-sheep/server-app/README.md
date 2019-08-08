
# Server application

### Prerequisites

* Docker
* Minikube / Cloud Kubernetes cluster
* httpie
* jq

---

## Build & run

* Locally
	```
	docker run -d --name postgres \
		-e POSTGRES_DB=server-app \
		-e POSTGRES_USER=user \
		-e POSTGRES_PASSWORD=secret \
		-p 5432:5432 \
		postgres:alpine
	mvnw clean spring-boot:run
	```

* On Docker
	```
	docker build . -t server-app-postgres:latest
	docker network create test
	docker run -d --name postgres \
		-e POSTGRES_DB=server-app \
		-e POSTGRES_USER=user \
		-e POSTGRES_PASSWORD=secret \
		-p 5432:5432 \
		--network test \
		postgres:alpine
	docker run -d --name server-app-postgres \
		-e SPRING_PROFILES_ACTIVE=docker \
		-e HEAP_SIZE=256M \
		-e META_SIZE=300M \
		-p 8080:8080 -p 8090:8090 \
		--network test \
		server-app-postgres
	docker logs server-app-postgres -f
	```

---

## REST endpoints

* `GET /users` get all
* `GET /users/{email}` get by email
* `POST /users` insert new
* `PUT /users` update
* `DELETE /users` delete all
* `DELETE /users/{email}` delete by email

---

## API calls

* Insert
	```
	http POST :8080/users email="matteo.baiguini@rabbit.com" name="Matteo Baiguini" age=33
	http POST :8080/users email="john.doe@rabbit.com" name="John Doe" age=42
	http POST :8080/users email="jane.doe@rabbit.com" name="Jane Doe" age=24
	http POST :8080/users email="clint.eastwood@rabbit.com" name="Clint Eastwood" age=75
	```
* Get
	```
	http :8080/users
	http :8080/users/matteo.baiguini@rabbit.com
	```
* Update
	```
	USER_ID=$(http :8080/users/clint.eastwood@rabbit.com | jq ".id")
	http PUT :8080/users id=$USER_ID email="clint.eastwood@rabbit.com" name="Clint Eastwood" age=89
	```
* Delete
	```
	http DELETE :8080/users/jane.doe@rabbit.com
	http DELETE :8080/users
	```
