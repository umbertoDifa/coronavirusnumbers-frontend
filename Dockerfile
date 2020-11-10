FROM cirrusci/flutter:latest AS builder

RUN mkdir /home/frontend_code
WORKDIR /home/frontend_code

RUN flutter channel beta

RUN flutter upgrade
RUN flutter config --enable-web
RUN flutter doctor

EXPOSE 8080

CMD flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0
