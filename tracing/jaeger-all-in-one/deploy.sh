#!/bin/sh

echo
echo "Tracing deployment started..."
echo

echo "    ... cleanup"
kubectl delete -f 2_all-in-one.yaml
kubectl delete -f 1_namespace.yaml

echo "    ... wait 30s"
sleep 30

echo "    ... deploy"
kubectl apply -f 1_namespace.yaml
kubectl apply -f 2_all-in-one.yaml

echo "    ... wait 15s"
sleep 15

echo
echo
echo "Tracing deployment completed"
echo
