FROM python:3.10-slim

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

ENV PROJECT "/Streamer"

COPY . ${PROJECT}

WORKDIR ${PROJECT}

RUN apt update && apt upgrade \
    && pip install --upgrade pip \
    && ls && pwd \
    && pip install -r requirements.txt

EXPOSE 8000
