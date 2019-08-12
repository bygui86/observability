#!/bin/sh
# Script to generate traffic

function stop() {
	echo
	echo "** CTRL-C pressed **"
	echo
	echo "Stop generating traffic"
	echo "    kill port-forward"
	kill -9 $PORT_FORW_PID
	echo "    end loop"
	WHILE_FLAG="false"
	echo
}

trap stop INT

KUBE_NS="white-rabbit"
KUBE_SVC="client-app"

HOST=$(minikube ip)
PORT=$(kubectl get svc -n $KUBE_NS | grep -i $KUBE_SVC | awk '{print $5}' | cut -d ',' -f 1 | sed 's,[0-9]*:,,' | sed 's,/TCP,,')
ENDPOINT="apis/users"

kubectl port-forward svc/$KUBE_SVC 8080:8080 -n $KUBE_NS &>/dev/null &
PORT_FORW_PID=$(ps au | grep -i 'kubectl port-forward' | grep -v 'grep' | awk '{print $2}')

echo "Generate traffic on:"
echo "    Namespace: $KUBE_NS"
echo "    Service: $KUBE_SVC"
echo "    IP address: $HOST"
echo "    Port: $PORT"
echo "    Endpoint: $ENDPOINT"
echo "    Port-forward PID: $PORT_FORW_PID"
echo
echo "** Press CTRL-C to stop **"
echo

WHILE_FLAG="true"
while [ $WHILE_FLAG == "true" ]; do
	echo "$(http --pretty none --print b $HOST:$PORT/$ENDPOINT | jq '. | length') users found"
	sleep .5
done
