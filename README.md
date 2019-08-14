
# Observability demos

## Useful instructions

### Port forwarding

`tracing`
```
kubectl port-forward -n tracing svc/jaeger-query 16686:80 &>/dev/null &
open http://localhost:16686
```
`monitoring`
```
kubectl port-forward -n monitoring svc/prometheus-k8s 9090:9090 &>/dev/null &
open http://localhost:9090
kubectl port-forward -n monitoring svc/grafana 3000:3000 &>/dev/null &
open http://localhost:3000
```
`logging`
```
kubectl port-forward -n logging svc/kibana 5601:5601 &>/dev/null &
open http://localhost:5601
```
`tools`
```
kubectl port-forward -n tools svc/weave-scope-app 4040:4040 &>/dev/null &
open http://localhost:4040
```
`applications`
```
kubectl port-forward -n black-sheep svc/client-app 8080:8080 &>/dev/null &
open http://localhost:8080/apis/users
kubectl port-forward -n white-rabbit svc/client-app 8081:8080 &>/dev/null &
open http://localhost:8081/apis/users
```

### Traffic generation

```
./applications/black-sheep/generate-traffic.sh
./applications/white-rabbit/generate-traffic.sh
```

---

## Roadmap

- [ ] [applications](applications)
  - [x] [black-sheep](applications/black-sheep)
    - [x] [server-app](applications/black-sheep/client-app-java)
    - [x] [client-app](applications/black-sheep/server-app)
  - [x] [white-rabbit](applications/white-rabbit)
    - [x] [server-app](applications/white-rabbit/client-app-java)
    - [x] [client-app](applications/white-rabbit/server-app)
  - [ ] bookinfo
  - [ ] shop
- [ ] [tracing](tracing)
  - [x] [jaeger all-in-one](tracing/jaeger-all-in-one)
  - [ ] jaeger operator
- [ ] [monitoring](monitoring)
  - [x] prometheus operator
  - [x] applications monitoring
  - [ ] db monitoring
  - [ ] tracing monitoring
  - [ ] logging monitoring
  - [ ] networking monitoring
  - [ ] tools monitoring
- [ ] [logging](logging)
  - [x] [efk](logging/efk) - `TODO: upgrade elasticsearch and kibana versions`
  - [ ] efk operator
- [ ] networking
  - [ ] ambassador
  - [ ] traefik
  - [ ] calico
  - [ ] network policies
- [ ] security
  - [ ] kubernetes rbac
  - [ ] falco (TBD)
- [x] [tools](tools)
  - [x] [kubeview](tools/kube-view)
  - [x] [weave-scope](tools/weave-scope)
