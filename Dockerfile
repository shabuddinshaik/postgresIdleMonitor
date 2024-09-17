FROM python:3.9-slim

WORKDIR /app

RUN apt-get update && apt-get install -y libpq-dev && \
    apt-get install -y --no-install-recommends gcc && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip

COPY monitor.py /app/monitor.py
COPY requirements.txt /app/requirements.txt

RUN pip install -r requirements.txt

ENV POSTGRES_HOST=localhost
ENV POSTGRES_PORT=5432
ENV POSTGRES_DB=mydatabase
ENV POSTGRES_USER=myuser
ENV POSTGRES_PASSWORD=mypassword
ENV INTERVAL_MINUTES=10
ENV IDLE_THRESHOLD="1 hour"

CMD ["python", "monitor.py"]
