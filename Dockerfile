# Builds production version of tc-bus-api inside Docker container,
# and runs it against the specified Topcoder backend (development or
# production) when container is executed.

FROM node:8.2.1
LABEL app="tc-bus-api" version="1.0"
RUN apt-get update
WORKDIR /opt/app
COPY . .
ARG KAFKA_URL 
ARG KAFKA_CLIENT_CERT 
ARG KAFKA_CLIENT_CERT_KEY
ARG LOG_LEVEL
ARG JWT_TOKEN_SECRET
ARG KAFKA_TOPIC_PREFIX
ARG ALLOWED_SERVICES
ARG JWT_TOKEN_EXPIRES_IN
ARG API_VERSION

ENV KAFKA_URL=$KAFKA_URL 
ENV KAFKA_CLIENT_CERT=$KAFKA_CLIENT_CERT 
ENV KAFKA_CLIENT_CERT_KEY=$KAFKA_CLIENT_CERT_KEY
ENV LOG_LEVEL=$LOG_LEVEL
ENV JWT_TOKEN_SECRET=$JWT_TOKEN_SECRET
ENV KAFKA_TOPIC_PREFIX=$KAFKA_TOPIC_PREFIX
ENV ALLOWED_SERVICES=$ALLOWED_SERVICES
ENV JWT_TOKEN_EXPIRES_IN=$JWT_TOKEN_EXPIRES_IN
ENV API_VERSION=$API_VERSION
RUN env
RUN npm install


#RUN npm test
#ENV NODE_ENV=$NODE_ENV
#ENTRYPOINT ["/usr/local/bin/npm", "start"]
#CMD [ "npm", "start"]
ENTRYPOINT ["npm", "start"]