#!/bin/sh

echo
echo "White-rabbit applications deployment started..."
echo

echo "    ... cleanup"
# kubectl delete -f kube/ingress
kubectl delete -f kube/grafana-update
kubectl delete -f kube/client-app
kubectl delete -f kube/server-app
kubectl delete -f kube/postgresql
kubectl delete -f kube/namespace.yaml

# echo "    ... watch pods after cleanup"
# watch kubectl get pod -l group=white-rabbit

echo "    ... wait 30s"
sleep 30

echo "    ... deploy"
kubectl apply -f kube/namespace.yaml
kubectl apply -f kube/postgresql
kubectl apply -f kube/server-app
kubectl apply -f kube/client-app
kubectl apply -f kube/grafana-update
# kubectl apply -f kube/ingress
# kubectl delete pod -l app.kubernetes.io/name=nginx-ingress-controller

# echo "    ... watch pods after deploy"
# watch kubectl get pod -l group=white-rabbit

echo "    ... wait 15s"
sleep 15

echo
echo
echo "White-rabbit applications deployment completed"
echo
