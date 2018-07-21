![Docker logo](https://github.com/marcosoliveirasoares94/Dockerfiles/blob/master/docker_logo.png)

# Instructions for use

Maven default installation mode.

Set the contents of the `maven.cfg` file in the Dockerfile file of your image.

The Content must be entered before the `ENTRYPOINT` command if it exists, otherwise it must be entered before the `CMD` command.

Warning: The `Environment Variables` content of the `maven.cfg` file should be changed as needed.

# Environment Variables

* **MAVEN_VERSION_MAJOR**:  `3`
* **MAVEN_VERSION_MINOR**:  `3.9`

# Issues

Please report any issues on [GitHub](https://github.com/marcosoliveirasoares94/Dockerfiles/issues).
