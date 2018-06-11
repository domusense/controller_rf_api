FROM python:3.6-stretch

RUN pip install gunicorn json-logging-py
RUN pip install falcon
RUN pip install rpi-rf 
MKDIR /gunicorn
COPY logging.conf /gunicorn/logging.conf
COPY gunicorn.conf /gunicorn/gunicorn.conf
COPY main.py /gunicorn/main.py
EXPOSE 8081
ENTRYPOINT ["/usr/local/bin/gunicorn", "--config", "/gunicorn/gunicorn.conf", "--log-config", "/gunicorn/logging.conf", "-b", ":8081", "main:app"]
