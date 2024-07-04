mini-ingress:
	minikube addons enable ingress && minikube addons enable ingress-dns

mini-start:
	minikube start

configure-env:
	eval $(minikube docker-env)

build:
	docker build AuthAPI/. -t auth_api:latest
	docker build ReviewsAPI/. -t reviews:latest
	docker build CinemaAPI/. -t cinema_api:latest
	docker build DjangoAdmin/. -t cinema_admin:latest
	docker build ETL/. -t etl:latest
	docker build FileAPI/. -t file_api:latest
	docker build Worker/. -t worker:latest
	docker build WebSocket/. -t ws:latest


apply-all:
	kubectl apply -f k8s/auth
	kubectl apply -f k8s/cinema
	kubectl apply -f k8s/elastic
	kubectl apply -f k8s/redis
	kubectl apply -f k8s/elk
	kubectl apply -f k8s/etl
	kubectl apply -f k8s/reviews
	kubectl apply -f k8s/webscoket
	kubectl apply -f k8s/s3
	kubectl apply -f k8s/.


delete-all:
	kubectl delete -f k8s/auth
	kubectl delete -f k8s/cinema
	kubectl delete -f k8s/elastic
	kubectl delete -f k8s/redis
	kubectl delete -f k8s/elk
	kubectl delete -f k8s/etl
	kubectl delete -f k8s/reviews
	kubectl delete -f k8s/websocket
	kubectl delete -f k8s/s3
	kubectl delete -f k8s/.


make-secrets:
	kubectl create secret generic secret-env --from-env-file .env.k8s

make-prod-secrets:
	kubectl create secret generic secret-env-prod --from-env-file .env.k8s.yan

make-alias:
	alias k8yc="kubectl --kubeconfig=$HOME/.kube/config-yc"

all: mini-start mini-ingress build apply-all

tunnel:
	minikube tunnel


configure-yc:
	yc managed-kubernetes cluster get-credentials <cluster_id> --external


prod-ingress:
	helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
	helm repo update
	helm install ingress-nginx ingress-nginx/ingress-nginx


apply-prod:
	kubectl apply -f k8s.prod/auth
	kubectl apply -f k8s.prod/.


delete-prod:
	kubectl delete -f k8s.prod/auth
	kubectl delete -f k8s.prod/.