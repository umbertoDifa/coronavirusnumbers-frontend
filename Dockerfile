FROM node:11.1.0-alpine

EXPOSE 8080
RUN apk add --no-cache --virtual .gyp \
        python

RUN mkdir /home/node/frontend
WORKDIR /home/node/frontend

COPY build/web ./build/web
#modify request to avoid credentials
RUN sed -i 's/include/omit/g' build/web/flutter_service_worker.js

#COPY server ./server

WORKDIR /home/node/frontend/build/web
#RUN npm install

#CMD ["python3 -m http.server"]
CMD /usr/bin/python -m SimpleHTTPServer 8080