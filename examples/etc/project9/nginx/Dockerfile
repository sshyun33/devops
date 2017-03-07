FROM nginx:1.11.8-alpine

MAINTAINER SEO SEUNG HYUN

COPY nginx.conf /etc/nginx/nginx.conf
RUN rm -rf /etc/nginx/conf.d
COPY conf.d /etc/nginx/conf.d
COPY ssl /etc/nginx/ssl
