![Docker logo](https://github.com/marcosoliveirasoares94/Docker/blob/master/Dockerfiles/docker_logo.png)

# Instructions for use

Java default installation mode.

Set the contents of the `java.cfg` file in the Dockerfile file of your image.

The Content must be entered before the `ENTRYPOINT` command if it exists, otherwise it must be entered before the `CMD` command.

Warning: The `Environment Variables` content of the `java.cfg` file should be changed as needed.

# Environment Variables

* **JAVA_PACKAGE**:	        `jdk`
* **JAVA_VERSION_MAJOR**:   `8`
* **JAVA_VERSION_MINOR**:   `112`
* **JAVA_VERSION_BUILD**:   `15`


# Issues

Please report any issues on [GitHub](https://github.com/marcosoliveirasoares94/Docker/issues).
