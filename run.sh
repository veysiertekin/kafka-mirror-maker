set -e

envsubst < /tmp/mirror-maker/producer.config > /etc/mirror-maker/producer.config
envsubst < /tmp/mirror-maker/consumer.config > /etc/mirror-maker/consumer.config

/etc/kafka/bin/kafka-mirror-maker.sh --whitelist ${WHITELIST}\
	--num.streams ${NUM_STREAMS} \
	--abort.on.send.failure true \
	--new.consumer \
	--producer.config /etc/mirror-maker/producer.config \
	--consumer.config /etc/mirror-maker/consumer.config
