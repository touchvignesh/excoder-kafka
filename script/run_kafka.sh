#!/bin/bash
if [[ -z "KAFKA_CONTROLLER_QUORUM_VOTERS" ]]; then
  echo 'Using default controller quorum voters'
else
  echo "Using controller quorum voters: ${KAFKA_CONTROLLER_QUORUM_VOTERS}"
  sed -r -i "s@^#?controller.quorum.voters=.*@controller.quorum.voters=$KAFKA_CONTROLLER_QUORUM_VOTERS@g" "/opt/kafka/config/kraft/server.properties"
fi

if [[ -z "$KAFKA_LISTENERS" ]]; then
  echo 'Using default listeners'
else
  echo "Using listeners: ${KAFKA_LISTENERS}"
  sed -r -i "s@^#?listeners=.*@listeners=$KAFKA_LISTENERS@g" "/opt/kafka/config/kraft/server.properties"
fi

if [[ -z "$KAFKA_ADVERTISED_LISTENERS" ]]; then
  echo 'Using default advertised listeners'
else
  echo "Using advertised listeners: ${KAFKA_ADVERTISED_LISTENERS}"
  sed -r -i "s@^#?advertised.listeners=.*@advertised.listeners=$KAFKA_ADVERTISED_LISTENERS@g" "/opt/kafka/config/kraft/server.properties"
fi

if [[ -z "$KAFKA_LISTENER_SECURITY_PROTOCOL_MAP" ]]; then
  echo 'Using default listener security protocol map'
else
  echo "Using listener security protocol map: ${KAFKA_LISTENER_SECURITY_PROTOCOL_MAP}"
  sed -r -i "s@^#?listener.security.protocol.map=.*@listener.security.protocol.map=$KAFKA_LISTENER_SECURITY_PROTOCOL_MAP@g" "/opt/kafka/config/kraft/server.properties"
fi

if [[ -z "$KAFKA_INTER_BROKER_LISTENER_NAME" ]]; then
  echo 'Using default inter broker listener name'
else
  echo "Using inter broker listener name: ${KAFKA_INTER_BROKER_LISTENER_NAME}"
  sed -r -i "s@^#?inter.broker.listener.name=.*@inter.broker.listener.name=$KAFKA_INTER_BROKER_LISTENER_NAME@g" "/opt/kafka/config/kraft/server.properties"
fi

echo "Format log directories"
${KAFKA_HOME}/bin/kafka-storage.sh format --cluster-id=123456 -c ${KAFKA_HOME}/config/kraft/server.properties
echo"Start Kafka server"
${KAFKA_HOME}/bin/kafka-server-start.sh ${KAFKA_HOME}/config/kraft/server.properties