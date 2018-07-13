FROM resin/rpi-raspbian:stretch-20180626

RUN apt-get update && apt-get upgrade
RUN pip install gunicorn json-logging-py install falcon rpi-rf
RUN sudo apt-get install pigpio python-pigpio python3-pigpio -y

RUN mkdir /srv/gunicorn
WORKDIR /srv/gunicorn

COPY logging.conf logging.conf
COPY gunicorn.conf gunicorn.conf
COPY main.py main.py

EXPOSE 8081

ENTRYPOINT ["/usr/local/bin/gunicorn", "--config", "gunicorn.conf", "--log-config", "/srv/gunicorn/logging.conf", "-b", ":8081", "main:app"]
