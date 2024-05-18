FROM nginx

COPY ./fonix-webpage/ /usr/share/nginx/html

RUN chown -R nginx:nginx /usr/share/nginx/html
RUN chmod -R 755 /usr/share/nginx/html

EXPOSE 80