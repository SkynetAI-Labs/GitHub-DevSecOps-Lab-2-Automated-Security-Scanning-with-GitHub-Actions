FROM python:3.14-slim

WORKDIR /app

COPY app/ ./app/

CMD ["python", "app/main.py"]
