# Use the official Ubuntu 22.04 base image
FROM ubuntu:22.04

# Set environment variables to non-interactive for apt
# This ensures that the package installation processes run without user interaction, 
# which is essential for automated builds in Docker.
ENV DEBIAN_FRONTEND=noninteractive

# Define build arguments for the ports
# These arguments allow you to specify port numbers at build time
# - `50051` is typically used for gRPC communication.
# - `14540` is commonly used for MAVLink UDP communication.
ENV GRPC_PORT=50051
ENV MAVLINK_PORT=14540

# Install dependencies
# Update the package list and install required utilities:
# - `wget`: For downloading files from the web.
# - `unzip`: For extracting .zip files.
# - `curl`: For making HTTP requests (used to get the latest release information).
# - `jq`: A lightweight and flexible command-line JSON processor (used to parse the JSON response from GitHub).
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    curl \
    jq

# Download and install the latest MAVSDK server
# Fetch the latest version tag of MAVSDK from GitHub using the GitHub API.
# - `LATEST_VERSION` stores the latest release tag (e.g., "v2.12.3").
# - `VERSION` extracts the version number from the tag (e.g., "2.12.3").
# Download the corresponding MAVSDK server binary for x86_64 architecture.
# Rename it to a standard location and make it executable.
# Move the downloaded MAVSDK server to /usr/local/bin and make it executable
RUN LATEST_VERSION=$(curl -sL https://api.github.com/repos/mavlink/MAVSDK/releases/latest | jq -r '.tag_name') && \
    echo "LATEST_VERSION: $LATEST_VERSION" && \
    VERSION=$(echo $LATEST_VERSION | cut -d 'v' -f2) && \
    echo "VERSION: $VERSION" && \
    wget https://github.com/mavlink/MAVSDK/releases/download/$LATEST_VERSION/mavsdk_server_musl_x86_64 && \
    mv mavsdk_server_musl_x86_64 /usr/local/bin/mavsdk_server && \
    chmod +x /usr/local/bin/mavsdk_server

# Expose the ports defined by the build arguments
# This makes the ports available for out source communication with the container
EXPOSE ${GRPC_PORT}
EXPOSE ${MAVLINK_PORT}

# Set the default command to run when the container starts.
# This command starts the MAVSDK server on gRPC port and listens for MAVLink communication on MAVLINK_PORT port over UDP.
CMD ["/bin/sh", "-c", "/usr/local/bin/mavsdk_server -p ${GRPC_PORT} udp://:${MAVLINK_PORT}"]
