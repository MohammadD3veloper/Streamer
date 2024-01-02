#!/bin/bash

function main {
    # Pull image from docker
    docker pull $DOCKER_USERNAME/$DOCKER_REPONAME

    # Apply configurations to k8s
    kubectl apply -f kubernetes/development/celery.yml --kubeconfig /home/root/.kube/config
    kubectl apply -f kubernetes/development/channel.yml --kubeconfig /home/root/.kube/config
    kubectl apply -f kubernetes/development/django.yml --kubeconfig /home/root/.kube/config
    kubectl apply -f kubernetes/development/postgres.yml --kubeconfig /home/root/.kube/config
    kubectl apply -f kubernetes/development/redis.yml --kubeconfig /home/root/.kube/config
    kubectl apply -f kubernetes/ingress/nginx.yml --kubeconfig /home/root/.kube/config
}

main