#!/bin/sh

echo
echo "Monitoring deployment started..."
echo

echo "    ... cleanup"
kubectl delete -f 8_prometheus
kubectl delete -f 7_prometheus-adapter
kubectl delete -f 6_node-exporter
kubectl delete -f 5_kube-state-metrics
kubectl delete -f 4_grafana
kubectl delete -f 3_alertmanager
kubectl delete -f 2_operator
kubectl delete -f 1_namespace

echo "    ... wait 30s"
sleep 30

echo "    ... deploy"
kubectl apply -f 1_namespace
kubectl apply -f 2_operator
kubectl apply -f 3_alertmanager
kubectl apply -f 4_grafana
kubectl apply -f 5_kube-state-metrics
kubectl apply -f 6_node-exporter
kubectl apply -f 7_prometheus-adapter
kubectl apply -f 8_prometheus

echo "    ... wait 15s"
sleep 15

echo
echo
echo "Monitoring deployment completed"
echo
