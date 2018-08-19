# Docker
Image Ubuntu with OpenSSH-Server and Supervisor installed among other basic software existing in an operating system. Service initialization process management. The list of installed software can be checked in the image file Dockerfile.

# Build
To create the image `marcosoliveirasoares94/ubuntu:latest`, execute the following command on the project folder:

    docker build -t marcosoliveirasoares94/ubuntu:latest .

# Run
Start your image:

    docker run --name <container-name> --hostname <container-name> -d -P marcosoliveirasoares94/ubuntu:latest

# Variables
* **TERM** =  xterm
* **SSH_ROOT_USER** =  root
* **SSH_ROOT_PASSWORD** =  secret

# Expose Port
* **22**

# Volumes
You can add any volume to the container: It can be useful to limit access to a particular section of your server.

# Issues
Please report any issues on [GitHub](https://github.com/marcosoliveirasoares94/Docker/issues).
