FROM ghcr.io/beathorst/docker-base:latest

MAINTAINER Janek Rüßmann

RUN apt-get update && \
    apt-get install -y \
        nginx \
        curl \
        supervisor \
        net-tools \
        htop \
        apache2 \
        vim

COPY supervisord.conf /etc/supervisor/supervisord.conf

COPY conf/nginx-site.conf /etc/nginx/sites-available/default
COPY conf/nginx-index.html /var/www/html/nginx/index.html

COPY conf/apache2-ports.conf /etc/apache2/ports.conf
COPY conf/apache2-site.conf /etc/apache2/sites-available/000-default.conf
COPY conf/apache2-index.html /var/www/html/apache2/index.html

EXPOSE 80 8080

CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
