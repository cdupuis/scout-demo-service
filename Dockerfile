FROM alpine:3.20@sha256:1e42bbe2508154c9126d48c2b8a75420c3544343bf86fd041fb7527e017a4b4a

RUN apk update && apk add libssl3=3.3.2-r1

ENV BLUEBIRD_WARNINGS=0 \
  NODE_ENV=production \
  NODE_NO_WARNINGS=1 \
  NPM_CONFIG_LOGLEVEL=warn \
  SUPPRESS_NO_CONFIG_WARNING=true

RUN apk add --no-cache \
  nodejs gdbm curl

COPY package.json ./

RUN  apk add --no-cache npm && npm i --no-optional && npm cache clean --force && apk del npm
 
COPY . /app

RUN adduser -D appuser
USER appuser

CMD ["node","/app/app.js"]

EXPOSE 3000