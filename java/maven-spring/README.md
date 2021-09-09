# Maven Spring Example
A basic Maven-backed Java Spring Boot application.

## Running the Application
This application includes a maven wrapper, and can be started from the `maven-spring` directory with the following command:
```shell
./mvnw bootRun
```

The Tomcat server will start, and the application's endpoint can be accessed at the following address:
```shell
localhost:8002/java/maven/health
```

##  Building an OCI with Google's general builder and Buildpacks
Before we get started, make sure to [install pack](https://buildpacks.io/docs/tools/pack/) or verify your installation by running:
```shell
pack --version
```

Using the [Google Cloud Platform general builder](https://github.com/GoogleCloudPlatform/buildpacks) we can easily create
a docker image for our application without the need for a Dockerfile.<br>
The following command will scan our project, determine that it is a Maven-backed Java application, and create an appropriate
docker image using environment variables specified in our project's `project.toml`:
```shell
pack build maven-spring-app --path=. --builder=gcr.io/buildpacks/builder:v1
```

That's it! Now we can use the `maven-spring-app` image that was created:
```shell
docker run -p 7000:8020 maven-spring-app:latest 
```

After a moment, the application will have started and can be validated with a quick curl:
```shell
curl localhost:7000/java/maven/health
```

## Reference Documentation

* [Official Apache Maven documentation](https://maven.apache.org/guides/index.html)
* [Google Cloud Platform general builder](https://github.com/GoogleCloudPlatform/buildpacks)
* [Buildpack documentation](https://buildpacks.io/docs)
