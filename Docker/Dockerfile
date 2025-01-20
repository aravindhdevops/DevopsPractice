FROM ubuntu
RUN apt update -y
RUN apt install tree -y
RUN apt install apache2 -y
COPY index.html /var/www/html
EXPOSE 8081
CMD ["apache2ctl","-D","FOREGROUND"]
