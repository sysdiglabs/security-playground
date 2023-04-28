FROM python:3.9

WORKDIR /app

COPY requirements.txt app.py /app/

RUN pip3 install -r requirements.txt

EXPOSE 8080

CMD ["gunicorn", "-b", ":8080", "--workers", "2", "--threads", "4", "--worker-class", "gthread", "--access-logfile", "-", "--error-logfile", "-", "app:app"]
