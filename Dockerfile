FROM python:3.7-alpine

RUN pip install pipenv==2018.11.26

WORKDIR /app

COPY Pipfile /app
COPY Pipfile.lock /app
RUN pipenv install --system --deploy

COPY app.py /app

EXPOSE 8080
CMD ["gunicorn", "-b", ":8080", "--access-logfile", "-", "--error-logfile", "-", "app:app"]
