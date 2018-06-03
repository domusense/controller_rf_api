docker build -t domu/gpio_api .

docker run -d --name rf_api --device /dev/gpiomem -e GUNICORN_WORKERS=4 -e GUNICORN_ACCESSLOG=- -p 8081:8081 domu/gpio_api
