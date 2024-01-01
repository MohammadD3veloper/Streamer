FROM python:3.11-slim

ENV PYTHONDONTWITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

ENV WORKDIR "/Streamer"

COPY . ${WORKDIR}

RUN apt-get update && apt-get upgrade -y && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

EXPOSE 8000