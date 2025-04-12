# mavsdk_docker

Docker for MAVSDK on Linux that exposes ports of your choice for gRPC and MAVLink communication (run on ubuntu 22.04).

TBD: docker of mavsdk for windows.

## how to use

You have two options to build it on your own or pull it:
1. Pull it
   * From GitHub packages:
    ```
    docker pull ghcr.io/mula2812/mavsdk_server:latest
    ```
   * From `dockerhub`:
     ```
     docker pull ilanmulakandov/mavsdk_server
     ```
2. Build:

Open your terminal at the directory of this project and write:

```
docker build -t mavsdk_server .
```

Another option for building if you have the mavsdk_server zip is that:

- Extract the mavsdk_server.tar.gz from the zip file (it doesn't matter to where you extract it)
- Enter in you terminal to the path your mavsdk_server.tar.gz extract to
- Write this command in your terminal:

```
docker load --input mavsdk_server.tar
```

And that is all. Now, in your locale DockerDesktop, there is a docker image of mavsdk_server

**_*Knowledge for enrichment*_** For creating this tar.gz, I run this line in my terminal:

```
docker save -o mavsdk_server.tar mavsdk_server:latest
```

Then, after it builds successfully, write the line below to start it:

```
docker run --name mavsdk_server_container -p {your_choosen_grpc_port}:{same_grpc_port} -p {your_choosen_mavlink_communication_port}:{same_mavlink_port} -e GRPC_PORT={your_choosen_grpc_port} -e MAVLINK_PORT={your_choosen_mavlink_communication_port} -it mavsdk_server
```

For example:

```
docker run --name mavsdk_server_container -p 50051:50051 -p 14540:14540 -e GRPC_PORT=50051 -e MAVLINK_PORT=14540 -it mavsdk_server
```

**Note** you sopposed to put in those ports the relevant numbers for your use
