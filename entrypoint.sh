#!/bin/bash

function main {
    # Pull image from docker
    docker pull $DOCKER_USERNAME/$DOCKER_REPONAME
    # delete running kubernetes clusters
    kubectl delete deployments --all
    kubectl delete services --all
    kubectl delete secrets --all
    kubectl delete ingress --all
    kubectl delete statefulset --all

    # Apply configurations to k8s
    kubectl apply -f kubernetes/secrets/docker.yml
    kubectl apply -f kubernetes/deployments/celery.yml
    kubectl apply -f kubernetes/deployments/channels.yml
    kubectl apply -f kubernetes/deployments/django.yml
    kubectl apply -f kubernetes/deployments/postgres.yml
    kubectl apply -f kubernetes/deployments/redis.yml
    kubectl apply -f kubernetes/ingress/nginx.yml
}

main