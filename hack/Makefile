KIND_NAME := fdi-minio
NAMESPACE := fdi-gateway

kind:
	kind create cluster \
		--name $(KIND_NAME) \
		--config .kind/kind-cluster.yaml \
		--kubeconfig .kind/config

	kubectl --kubeconfig .kind/config \
		create namespace $(NAMESPACE)

helm-setup:
	helm repo add bitnami https://charts.bitnami.com/bitnami

minio:
	export KUBECONFIG=.kind/config; \
	helm install etcd bitnami/etcd -f .kind/etcd-values.yaml -n $(NAMESPACE)

	export KUBECONFIG=.kind/config; \
	helm install minio bitnami/minio -f .kind/minio-values.yaml -n $(NAMESPACE)

	export KUBECONFIG=.kind/config; \
	kubectl patch secret minio -n fdi-gateway --type='json' \
		-p='[{"op" : "replace" ,"path" : "/data/access-key" ,"value" : "bWluaW9hZG1pbg=="}]'

	export KUBECONFIG=.kind/config; \
	kubectl patch secret minio -n fdi-gateway --type='json' \
		-p='[{"op" : "replace" ,"path" : "/data/secret-key" ,"value" : "bWluaW9hZG1pbg=="}]'

	export KUBECONFIG=.kind/config; \
	kubectl rollout restart deployment minio -n fdi-gateway

teardown:
	export KUBECONFIG=.kind/config; \
	helm uninstall -n fdi-gateway etcd

	export KUBECONFIG=.kind/config; \
	helm uninstall -n fdi-gateway minio

delete:
	kind delete clusters $(KIND_NAME)

port-forward:
	@echo "Head to http://localhost:9000"
	@echo "Creds are minioadmin:minioadmin"
	kubectl --kubeconfig=.kind/config \
		port-forward -n $(NAMESPACE) \
		svc/minio 9000:9000

cropimaging frontiercounts:
	mc mb -p minio-local/$@
	echo $@-file | mc pipe minio-local/$@/$@-file.txt

blair jim:
	mc admin user add minio-local $@ minioadmin
	mc admin policy set minio-local $@ user=$@

fake-users:
	mc config host add minio-local http://localhost:9000 minioadmin minioadmin
