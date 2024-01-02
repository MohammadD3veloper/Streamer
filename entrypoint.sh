#!/bin/bash

function main {
    # Pull image from docker
    docker pull $DOCKER_USERNAME/$DOCKER_REPONAME

    # Apply configurations to k8s
    kubectl apply -f kubernetes/development/celery.yml --kubeconfig /root/.kube/config
    kubectl apply -f kubernetes/development/channel.yml --kubeconfig /root/.kube/config
    kubectl apply -f kubernetes/development/django.yml --kubeconfig /root/.kube/config
    kubectl apply -f kubernetes/development/postgres.yml --kubeconfig /root/.kube/config
    kubectl apply -f kubernetes/development/redis.yml --kubeconfig /root/.kube/config
    kubectl apply -f kubernetes/ingress/nginx.yml --kubeconfig /root/.kube/config
}

main