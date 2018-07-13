FROM python:3.6-stretch

RUN mkdir /srv/gunicorn


RUN cd /srv
RUN wget abyz.me.uk/rpi/pigpio/pigpio.tar
RUN tar xf pigpio.tar
RUN cd PIGPIO
RUN make
RUN sudo make install
RUN rm pigpio.tar
RUN sudo rm -rf PIGPIO

#RUN apt-get update && apt-get upgrade
RUN apt-get install pigpio python3-pigpio -y
RUN pip install gunicorn json-logging-py
RUN pip install falcon
RUN pip install rpi-rf 


WORKDIR /srv/gunicorn
COPY logging.conf logging.conf
COPY gunicorn.conf gunicorn.conf
COPY main.py main.py
EXPOSE 8081
ENTRYPOINT ["/usr/local/bin/gunicorn", "--config", "gunicorn.conf", "--log-config", "/srv/gunicorn/logging.conf", "-b", ":8081", "main:app"]
