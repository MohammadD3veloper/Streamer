FROM python:3.11-slim

ENV PYTHONDONTWITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

ENV SUPERUSER_EMAIL=test@gmail.com
ENV SUPERUSER_PASSWORD=1234567890
ENV SUPERUSER_USERNAME=test

ENV WORKDIR "/Streamer"

COPY . ${WORKDIR}

WORKDIR ${WORKDIR}

RUN ls && apt-get update && apt-get upgrade -y && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

RUN python manage.py migrate

RUN python manage.py collectstatic --noinput

RUN export DJANGO_SUPERUSER_EMAIL=${SUPERUSER_EMAIL}
RUN export DJANGO_SUPERUSER_PASSWORD=${SUPERUSER_PASSWORD}
RUN python manage.py createsuperuser --no-input --username ${SUPERUSER_USERNAME}

EXPOSE 8000