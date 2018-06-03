$ docker build -t domu/gunicorn .

$ docker run -d -e GUNICORN_WORKERS=4 -e GUNICORN_ACCESSLOG=- -p 8081:8081 domu/gunicorn --name rf_api
