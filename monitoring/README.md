
# Observability demos - Monitoring

## Deploy

```
kubectl apply -f 1_namespace
kubectl apply -f 2_operator
kubectl apply -f 3_alertmanager
kubectl apply -f 4_grafana
kubectl apply -f 5_kube-state-metrics
kubectl apply -f 6_node-exporter
kubectl apply -f 7_prometheus-adapter
kubectl apply -f 8_prometheus
```

## Fix (e.g. running on Minikube)

```
kubectl delete servicemonitors.monitoring.coreos.com kube-apiserver
kubectl delete servicemonitors.monitoring.coreos.com kube-controller-manager
kubectl delete servicemonitors.monitoring.coreos.com kube-scheduler
kubectl apply -f 9_kube-fix
```
