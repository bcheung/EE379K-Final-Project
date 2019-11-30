DIR ?= deploy

apply: $(DIR)/*
	for file in $^ ; do \
    microk8s.kubectl apply -f $${file}; \
  done

delete: $(DIR)/*
	for file in $^ ; do \
    microk8s.kubectl delete -f $${file}; \
  done

get-pods:
	microk8s.kubectl get pods --all-namespaces

get-dvwa-svc:
	microk8s.kubectl get services/web-dvwa-svc --all-namespaces

watch:
	watch microk8s.kubectl get all