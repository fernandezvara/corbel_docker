#!/bin/bash

if [ $# -eq 0 ]
then
  echo "No service name. Exitting ..."
  exit 1
fi

CORBEL_SERVICE=$1

CORBEL_OPTS=""

#CORBEL_OPTS="$CORBEL_OPTS -Ddw.http.port=$DW_HTTP_PORT"
#CORBEL_OPTS="$CORBEL_OPTS -Ddw.http.adminPort=$DW_HTTP_ADMINPORT"
CORBEL_OPTS="$CORBEL_OPTS -Diam.mongodb.host=$MONGODB_HOST"
CORBEL_OPTS="$CORBEL_OPTS -Diam.mongodb.port=$MONGODB_PORT"
CORBEL_OPTS="$CORBEL_OPTS -Diam.mongodb.autoConnectRetry=$MONGODB_AUTOCONNECTRETRY"
CORBEL_OPTS="$CORBEL_OPTS -Diam.mongodb.connectionsPerHost=$MONGODB_CONNECTIONSPERHOST"
CORBEL_OPTS="$CORBEL_OPTS -Dauth.redis.host=$REDIS_HOST"
CORBEL_OPTS="$CORBEL_OPTS -Dauth.redis.port=$REDIS_PORT"
CORBEL_OPTS="$CORBEL_OPTS -Drabbitmq.host=$RABBITMQ_HOST"
CORBEL_OPTS="$CORBEL_OPTS -Drabbitmq.port=$RABBITMQ_PORT"
CORBEL_OPTS="$CORBEL_OPTS -Drabbitmq.username=$RABBITMQ_USER"
CORBEL_OPTS="$CORBEL_OPTS -Drabbitmq.password=$RABBITMQ_PASSWORD"

# Adding variables that are not empty
[[ $MONGODB_USER     && ${MONGODB_USER-x} ]]     && CORBEL_OPTS="$CORBEL_OPTS -Diam.mongodb.user=$MONGODB_USER"
[[ $MONGODB_PASSWORD && ${MONGODB_PASSWORD-x} ]] && CORBEL_OPTS="$CORBEL_OPTS -Diam.mongodb.password=$MONGODB_PASSWORD"
[[ $REDIS_PASSWORD   && ${REDIS_PASSWORD-x} ]]   && CORBEL_OPTS="$CORBEL_OPTS -Dauth.redis.password=$REDIS_PASSWORD"

# Starts the service
java -jar $CORBEL_OPTS $CORBEL_SERVICE.jar server 
