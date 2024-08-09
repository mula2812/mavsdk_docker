# mavsdk_docker

docker of mavsdk for linux that exposes the ports
TBD: docker of mavsdk for windows that expose is port

## how to use

Open your terminal at the dirctory of this project, and write:

```
docker build -t mavsdk_server .
```

another option for build if you have the linux_mavsdk_server zip is that:

- Extract the mavsdk_server.tar.gz from the zip file (it doesn't matter to where you extract it)
- Enter in you terminal to the path your mavsdk_server.tar.gz extract to
- Write this command in your terminal:

```
docker load --input mavsdk_server.tar
```

And this is all now in you DockerDesktop locale thier is docker image of mavsdk_server

**_*Knowledge for enrichment*_** for creating this tar.gz I run this line in my terminal:

```
docker save -o linux_mavsdk_server.tar mavsdk_server:latest
```

Then after it build sucssefuly, write the line below to start it:

```
docker run --name mavsdk_server_container -p {your_choosen_grpc_port}:{same_grpc_port} -p {your_choosen_mavlink_communication_port}:{same_mavlink_port} -e GRPC_PORT=50051 -e MAVLINK_PORT=14540 -it mavsdk_server
```

For example:

```
docker run --name mavsdk_server_container -p 50051:50051 -p 14540:14540 -e GRPC_PORT=50051 -e MAVLINK_PORT=14540 -it mavsdk_server
```

**Note** you sopposed to put in those ports the relevant numbers for your use
