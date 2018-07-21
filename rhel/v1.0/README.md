# Docker
Image Red Hat Enterprise Linux with OpenSSH-Server and Supervisor installed among other basic software existing in an operating system. The list of installed software can be checked in the image file Dockerfile.

# Build
To create the image `marcosoliveirasoares94/rhel:v1.0`, execute the following command on the project folder:

    docker build -t marcosoliveirasoares94/rhel:v1.0 .

# Run
Start your image:

    docker run --name <container-name> --hostname <container-name> -d -P marcosoliveirasoares94/rhel:v1.0

# Variables
* **TERM** =  xterm
* **SSH_ROOT_USER** =  root
* **SSH_ROOT_PASSWORD** =  secret

# Ports
* **22**

# Volumes
You can add any volume to the container: It can be useful to limit access to a particular section of your server.

# Issues
Please report any issues on [GitHub](https://github.com/marcosoliveirasoares94/Docker/issues).
