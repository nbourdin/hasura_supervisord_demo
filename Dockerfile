FROM hasura/graphql-engine:latest

RUN apt-get update && apt-get install -y \
  ca-certificates \
  curl

ARG NODE_VERSION=14.16.0
ARG NODE_PACKAGE=node-v$NODE_VERSION-linux-x64
ARG NODE_HOME=/opt/$NODE_PACKAGE

ENV NODE_PATH $NODE_HOME/lib/node_modules
ENV PATH $NODE_HOME/bin:$PATH

RUN curl https://nodejs.org/dist/v$NODE_VERSION/$NODE_PACKAGE.tar.gz | tar -xzC /opt/

RUN apt-get install supervisor -y

WORKDIR /server
COPY server server
RUN npm install

COPY hasura hasura

COPY supervisord.conf .

ENV NODE_ENV production
EXPOSE 3000 8000

CMD ["/usr/bin/supervisord", "-c", "./supervisord.conf"]