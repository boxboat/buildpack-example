# Python FastAPI Example
A basic Python FastAPI application.

## Running the Application
Install the application dependencies with the following:
```shell
pip install -r requirements.txt
```

You should then be able to start the FastAPI application from the `fastapi` directory using the following:
```shell
uvicorn --port 8003 --host 0.0.0.0 fastapi_app.health_controller:app
```

The server will start, and the application's endpoint can be accessed at the following address:
```shell
localhost:8003/python/health
```

##  Building an OCI with Google's general builder and Buildpacks
Before we get started, make sure to [install pack](https://buildpacks.io/docs/tools/pack/) or verify your installation by running:
```shell
pack --version
```

Using the [Google Cloud Platform general builder](https://github.com/GoogleCloudPlatform/buildpacks) we can easily create
a docker image for our application without the need for a Dockerfile.<br>
The following command will scan our project, determine that it is a Python application, and create an appropriate
docker image using environment variables specified in our project's `project.toml`:
```shell
pack build python-fastapi-app --path=. --builder=gcr.io/buildpacks/builder:v1
```

That's it! Now we can use the `maven-spring-app` image that was created:
```shell
docker run -p 8000:8030 python-fastapi-app:latest 
```

After a moment, the application will have started and can be validated with a quick curl:
```shell
curl localhost:8000/python/health
```

## Reference Documentation

* [Official Python FastAPI documentation](https://fastapi.tiangolo.com/)
* [Google Cloud Platform general builder](https://github.com/GoogleCloudPlatform/buildpacks)
* [Buildpack documentation](https://buildpacks.io/docs)

