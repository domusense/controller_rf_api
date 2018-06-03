FROM python:2.7.15-stretch

RUN pip install gunicorn json-logging-py
RUN pip install falcon

COPY logging.conf /logging.conf
COPY gunicorn.conf /gunicorn.conf
COPY main.py /main.py

EXPOSE 8081

ENTRYPOINT ["/usr/local/bin/gunicorn", "--config", "/gunicorn.conf", "--log-config", "/logging.conf", "-b", ":8081", "main:app"]
