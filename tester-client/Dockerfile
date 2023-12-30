FROM python:3.8

LABEL org.opencontainers.image.authors="manuelbcd"

RUN echo Security Playground Client Demo App

COPY client.py /client.py

RUN pip install requests

ENTRYPOINT ["python", "/client.py"]
