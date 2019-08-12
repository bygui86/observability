
# Observability demos - Logging - EFK

## Deploy

1. Deploy
	```
	kubectl apply -f .
	```

2. Check connection Fluentd-Elastisearch
	```
	kubectl get pods -n kube-system
	kubectl logs fluentd-* -n kube-system -f
	```
	You should see that Fluentd connect to Elasticsearch within the logs:
	```
	Connection opened to Elasticsearch cluster => {:host=>"elasticsearch.logging", :port=>9200, :scheme=>"http", :path=>""}
	```

3. Configure Kibana
	```
	open http://$(minikube ip):$(kubectl get svc -n logging | grep -i kibana | awk '{print $5}' | cut -d ',' -f 1 | sed 's,[0-9]*:,,' | sed 's,/TCP,,')
	```
	1. Left menu: "Management"
	2. Kibana group: "Index Patterns"
	3. Button: "Create index pattern"
	4. Index creation form 1:
		Index pattern: logstash*
	5. Button: "Next step"
	6. Index creation form 2:
		Time Filter field name: @timestamp
	7. Button: "Create index pattern"
	8. Leave open the window

4. Check logs from your applications in Kibana
	Left menu: "Discover" to see logs
