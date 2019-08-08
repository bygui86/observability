#!/bin/sh

echo
echo "Tracing deployment started..."
echo

echo "    ... cleanup"
kubectl delete -f jaeger-all-in-one.yaml
kubectl delete -f namespace.yaml

echo "    ... wait 30s"
sleep 30

echo "    ... deploy"
kubectl apply -f namespace.yaml
kubectl apply -f jaeger-all-in-one.yaml

echo "    ... wait 15s"
sleep 15

echo
echo
echo "Tracing deployment completed"
echo
