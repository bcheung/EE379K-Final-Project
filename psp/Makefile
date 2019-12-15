DIR ?= deploy

all: compose-down compose-build push apply

clean: delete compose-down

compose-build:
	cd app; \
	docker-compose build

push:
	docker tag app_non-root_debian localhost:32000/app_non-root_debian:k8s
	docker push localhost:32000/app_non-root_debian
	docker tag app_root_debian localhost:32000/app_root_debian:k8s
	docker push localhost:32000/app_root_debian

compose-down:
	cd app; \
	docker-compose down -v --rmi all --remove-orphans

apply: $(DIR)/*
	for file in $^ ; do \
    microk8s.kubectl apply -f $${file}; \
  done

delete: $(DIR)/*
	for file in $^ ; do \
    microk8s.kubectl delete -f $${file}; \
  done
	
watch-k8s:
	watch microk8s.kubectl get all -o wide

watch-docker:
	watch docker container ls
