FROM resin/rpi-raspbian:stretch-20180626

RUN apt-get update && apt-get upgrade
RUN apt-get install python3 python3-pip pigpio python-pigpio python3-pigpio -y
RUN pip3 install setuptools
RUN pip3 install gunicorn json-logging-py falcon rpi-rf
RUN mkdir /srv/gunicorn

WORKDIR /srv/gunicorn

COPY logging.conf logging.conf
COPY gunicorn.conf gunicorn.conf
COPY main.py main.py

EXPOSE 8081

ENTRYPOINT ["/usr/local/bin/gunicorn", "--config", "gunicorn.conf", "--log-config", "/srv/gunicorn/logging.conf", "-b", ":8081", "main:app"]
