FROM python:3.6-stretch

RUN mkdir /srv/gunicorn

WORKDIR /srv/gunicorn

RUN apt-get install unzip -y
RUN wget https://github.com/joan2937/pigpio/archive/master.zip
RUN unzip master.zip
RUN cd pigpio-master
RUN make
RUN sudo make install
RUN rm master.zip
RUN sudo rm -rf pigpio-master

#RUN apt-get update && apt-get upgrade
RUN apt-get install pigpio python3-pigpio -y
RUN pip install gunicorn json-logging-py
RUN pip install falcon
RUN pip install rpi-rf 



COPY logging.conf logging.conf
COPY gunicorn.conf gunicorn.conf
COPY main.py main.py

EXPOSE 8081

ENTRYPOINT ["/usr/local/bin/gunicorn", "--config", "gunicorn.conf", "--log-config", "/srv/gunicorn/logging.conf", "-b", ":8081", "main:app"]
