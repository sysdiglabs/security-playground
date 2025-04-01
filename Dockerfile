FROM python:3.9-slim

RUN pip install --upgrade pipenv

WORKDIR /app
COPY . .
RUN pipenv install --system --deploy

EXPOSE 8080

ENTRYPOINT ["./entrypoint.sh"]
