#!/usr/bin/env bash

# Navigate into the nested code directory
cd /app/app || exit 1

# Add the source directory to Python's module lookup path
export PYTHONPATH="/app/app:$PYTHONPATH"

# Start the Celery worker process in the background
python -m celery -A workers worker --loglevel=info &

# Start the FastAPI Uvicorn web server in the foreground
exec uvicorn main:app --host 0.0.0.0 --port "${PORT:-10000}"
