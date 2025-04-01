#!/bin/bash

gunicorn -b :8080 --workers 2 --threads 4 --worker-class gthread --access-logfile - --error-logfile - app:app