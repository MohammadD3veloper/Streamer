FROM python:3.10-slim

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

ENV PROJECT "/Streamer"

COPY . ${PROJECT}

RUN apt update && apt upgrade \
    && pip install --upgrade pip \
    && pip install -r requirements.txt \
    && useradd -mG sudo -s /bin/bash django

USER django

EXPOSE 8000
