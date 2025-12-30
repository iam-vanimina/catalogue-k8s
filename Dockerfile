FROM node:20 AS builder
WORKDIR /opt/server
COPY package.json /opt/server/
COPY *.js .
RUN npm install

FROM node:20.18.0-alpine3.20
EXPOSE 8080
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop && \
    mkdir /opt/server && \
    chown -R roboshop:roboshop /opt/server
WORKDIR /opt/server
COPY --from=builder /opt/server /opt/server
USER roboshop
CMD ["node", "server.js"]