# kafka-mirror-maker

An OpenJDK 11 & Kafka 2.3 upgraded version of [ambuds/mirror-maker](https://github.com/srotya/docker-kafka-mirror-maker) image . Also, performance and durability improvements has been made by default.

Docker image: [https://hub.docker.com/r/veysiertekin/kafka-mirror-maker/](https://hub.docker.com/r/veysiertekin/kafka-mirror-maker/)

### Build

```
git clone https://github.com/veysiertekin/kafka-mirror-maker.git
cd kafka-mirror-maker
docker build -t mirror-maker:latest .
```

**Note: Docker is expected to be installed where you run the build**

### Environment Variables
|    Variable Name    |                   Description                |   Defaults |
|---------------------|----------------------------------------------|------------|
|    DESTINATION      | bootstrap.servers for the Destination Kafka Cluster |localhost:9092|
|      SOURCE         | bootstrap.servers for the Source Kafka Cluster |localhost:9092|
|     WHITELIST       | Topics to mirror     | * |
|     GROUPID         | Consumer group id for Kafka consumer | `_mirror_maker` |

#### Usage
```
docker run -it -e DESTINATION=xxx.xxx.com:9092 -e SOURCE=xxx.xxx.com:9092 -e WHITELIST=<TOPIC NAME> mirror-maker:latest
```

#### Kubernetes Usage

To deploy this image in Kubernetes here's the template.

```
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: mirror-maker
spec:
  replicas: 1
  template:
    metadata:
      labels:
        name: mirror-maker
    spec:
      containers:
      - name: mirror-maker
        image: veysiertekin/kafka-mirror-maker
        imagePullPolicy: Always
        env:
        - name: "WHITELIST"
          value: "*"
        - name: "DESTINATION"
          value: "localhost:9092"
        - name: "SOURCE"
          value: "localhost:9092"
```


### License

Apache 2.0
