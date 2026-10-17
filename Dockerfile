FROM python:3.14-alpine3.23

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

RUN apk upgrade --no-cache \
    && python -m pip uninstall -y pip \
    && addgroup -S -g 10001 appuser \
    && adduser -S -D -H -u 10001 -G appuser appuser

COPY --chown=appuser:appuser app/ ./app/

USER appuser

CMD ["python", "app/main.py"]
