
# Observability demos - Tools

## Kube-View

```
kubectl apply -f kube-view
kubectl port-forward svc/kubeview 8000:8000 -n tools
```

---

## Weave-Scope

```
kubectl apply -f weave-scope
kubectl port-forward svc/weave-scope-app 4040:4040 -n tools
```
