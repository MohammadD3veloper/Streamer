#!/bin/bash

function main {
    # Pull image from docker
    docker pull $DOCKER_USERNAME/$DOCKER_REPONAME

    # Apply configurations to k8s
    kubectl apply -f kubernetes/development/celery.yml --context=streamer-context
    kubectl apply -f kubernetes/development/channel.yml --context=streamer-context
    kubectl apply -f kubernetes/development/django.yml --context=streamer-context
    kubectl apply -f kubernetes/development/postgres.yml --context=streamer-context
    kubectl apply -f kubernetes/development/redis.yml --context=streamer-context
    kubectl apply -f kubernetes/ingress/nginx.yml --context=streamer-context
}

main