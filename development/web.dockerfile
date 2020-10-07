FROM nginx

ADD development/vhost.conf /etc/nginx/conf.d/default.conf

COPY public /var/www/public

WORKDIR /var/www