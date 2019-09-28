FROM centos:centos7

# configure java runtime
ENV JAVA_HOME=/opt/java \
  JAVA_VERSION_MAJOR="11" \
  JAVA_VERSION_MINOR="28"

# install OpenJDK
RUN mkdir -p /opt \
  && curl --fail --silent --location --retry 3 \
  https://download.java.net/openjdk/jdk${JAVA_VERSION_MAJOR}/ri/openjdk-${JAVA_VERSION_MAJOR}+${JAVA_VERSION_MINOR}_linux-x64_bin.tar.gz \
  | gunzip \
  | tar -x -C /opt \
  && ln -s /opt/jdk-${JAVA_VERSION_MAJOR} ${JAVA_HOME}

RUN curl -O http://kozyatagi.mirror.guzel.net.tr/apache/kafka/2.3.0/kafka_2.11-2.3.0.tgz && \
	tar xzvf kafka_2.11-2.3.0.tgz && \
	mv kafka_2.11-2.3.0 /etc/kafka
RUN yum -y install gettext

ENV PATH=${PATH}:${JAVA_HOME}/bin:${JAVA_HOME}/sbin

ENV WHITELIST *
ENV DESTINATION "localhost:6667"
ENV SOURCE "localhost:6667"
ENV GROUPID "_mirror_maker"
ENV NUM_STREAMS "12"
ENV JMX_PORT "9999"
ENV KAFKA_HEAP_OPTS "-XX:MaxRAMPercentage=70 -XshowSettings:vm -XX:+ExitOnOutOfMemoryError"

RUN mkdir -p /etc/mirror-maker/
RUN mkdir -p /tmp/mirror-maker/
ADD ./consumer.config /tmp/mirror-maker/
ADD ./producer.config /tmp/mirror-maker/
ADD ./run.sh /etc/mirror-maker/
RUN chmod +x /etc/mirror-maker/run.sh

CMD /etc/mirror-maker/run.sh
