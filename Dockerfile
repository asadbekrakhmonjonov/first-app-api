FROM python:3.9-alpine3.13
LABEL maintainer="recklesstag7.com"

ENV PYTHONPATH=/app

COPY ./requirements.txt /tmp/requirements.txt
COPY ./app /app
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    rm -rf /tmp && \
    if [ -f requirements.dev.txt ] && [ "$DEV" = "true" ]; then \
    /py/bin/pip install -r /tmp/requirements.dev.txt; \
    fi && \
    adduser --disabled-password --no-create-home django-user


ENV PATH="/py/bin:$PATH"

USER django-user