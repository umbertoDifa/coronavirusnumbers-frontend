FROM cirrusci/flutter:latest AS builder

COPY . /home/frontend_code
WORKDIR /home/frontend_code

USER root

RUN chmod 777 pubspec.lock

RUN flutter channel beta
RUN flutter upgrade
RUN flutter config --enable-web

RUN flutter build web


FROM node:11.1.0-alpine

EXPOSE 8080

RUN mkdir /home/node/frontend
WORKDIR /home/node/frontend

COPY --from=builder /home/frontend_code/build/web ./build/web

#modify request to avoid credentials
RUN sed -i 's/include/omit/g' build/web/flutter_service_worker.js

COPY server ./server
WORKDIR /home/node/frontend/server

RUN npm install

CMD node server.js
