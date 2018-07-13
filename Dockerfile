FROM twhtanghk/arm-node

WORKDIR /root

RUN apt-get update \
&&  apt-get install -y git-core \
&&  git clone https://github.com/joan2937/pigpio \
&&  (cd pigpio ; make install) \
&&  rm -rf pigpio /var/cache/apt/archives/* /var/lib/apt/lists/*

#RUN pip install gunicorn json-logging-py
#RUN pip install falcon
#RUN pip install rpi-rf 

#COPY logging.conf logging.conf
#COPY gunicorn.conf gunicorn.conf
#COPY main.py main.py

#EXPOSE 8081
#ENTRYPOINT ["/usr/local/bin/gunicorn", "--config", "gunicorn.conf", "--log-config", "/srv/gunicorn/logging.conf", "-b", ":8081", "main:app"]
