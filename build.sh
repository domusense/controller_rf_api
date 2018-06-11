docker build -t domu/gpio_api .
sudo mkdir /rfapi

docker run -d -v /rfapi:/gunicorn --name rfapi --device /dev/gpiomem -e GUNICORN_WORKERS=4 -e GUNICORN_ACCESSLOG=- -p 8081:8081 domu/gpio_api
