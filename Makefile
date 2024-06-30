mini-ingress:
	minikube addons enable ingress && minikube addons enable ingress-dns

mini-start:
	minikube start

configure-env:
	eval $(minikube docker-env)

build:
	docker build AuthAPI/. -t auth_api:latest && docker build ReviewsAPI/. -t reviews:latest:

apply-all:
	kubectl apply -f k8s/.

make-secrets:
	kubectl create secret generic secret-env --from-env-file .env.k8s

make-alias:
	alias k8yc="kubectl --kubeconfig=$HOME/.kube/config-yc"

all: mini-start mini-ingress build apply-all

tunnel:
	minikube tunnel
