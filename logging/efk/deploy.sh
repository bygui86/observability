#!/bin/sh

echo
echo "Logging deployment started..."
echo

echo "    ... cleanup"
kubectl delete -f 4_kibana
kubectl delete -f 3_fluentd
kubectl delete -f 2_elasticsearch
kubectl delete -f 1_namespace

echo "    ... wait 30s"
sleep 30

echo "    ... deploy"
kubectl apply -f 1_namespace
kubectl apply -f 2_elasticsearch
kubectl apply -f 3_fluentd
kubectl apply -f 4_kibana

echo "    ... wait 15s"
sleep 15

echo
echo
echo "Logging deployment completed"
echo
