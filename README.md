# mavsdk_docker

docker of mavsdk for linux that exposes the ports
TBD: docker of mavsdk for windows that expose is port

## how to use

Open your terminal at the dirctory of this project, and write:

```
docker build -t mavsdk_server .
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
