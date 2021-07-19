# Buildpack Example
This project contains four example applications using Groovy, Java(Gradle), Java(Maven), and Python, to demonstrate the power of Buildpacks.


## What is a Buildpack?
"Buildpacks provide framework and runtime support for applications. <br>
Buildpacks examine your apps to determine all the dependencies it needs and configure them appropriately to run on any cloud." - [Buildpack Concepts](https://buildpacks.io/docs/concepts/)<br>

Buildpacks can be orderly bundled together in a Builder to support multiple languages or application run-time environments simultaneously.


## Why use Buildpacks?
Buildpacks can take out the hassle of maintaining: container imaging standards, base images with custom configurations, and build/run-time version updates, to name a few benefits.


##  Building an OCI with Google's general builder and Buildpacks
Before we get started, make sure to [install pack](https://buildpacks.io/docs/tools/pack/) or verify your installation by running:
```shell
pack --version
```

Using the [Google Cloud Platform general builder](https://github.com/GoogleCloudPlatform/buildpacks) we can easily create
a Docker image for our application without the need for a Dockerfile.<br>
Using `pack` and the GCP builder we can build a Docker image using the following command:
```shell
pack build <docker-image-name> --path=<path-to-app-source> --builder=gcr.io/buildpacks/builder:v1 -e GOOGLE_ENTRYPOINT=<desired-docker-entrypoint-command>
```
> The GCP builder contains support for LTS versions of Python, Java, Go, Node, and .NET Core.

Instructions for using Buildpacks with the individual examples in this project can be found in their project source:
* [Groovy](groovy/groovy-spring/README.md)
* [Java Gradle](java/gradle-spring/README.md)
* [Java Maven](java/maven-spring/README.md)
* [Python](python/fastapi/README.md)


## Buildpack using prop-pack and Kubernetes with a local Docker registry
Before we get started make sure to [install k3d](https://k3d.io/) or verify your installation by running:
```shell
k3d --version
```

Next we need to create a cluster and registry for this example using a helper script included:
```shell
sh cluster-with-registry.sh
```

Now we're ready to use `prop-pack.bash` to build all the Docker images in this example, and push them to our local Docker registry. <br>
This helper script accepts an array of paths to project source directories as input, and uses Buildpacks to create Docker images based on configurations in 'buildpack.properties' files.
The [prop-pack.bash unmodified source code](https://gist.github.com/dsm0014/c31ed0109a2d0da4956f7c1561bc1ef5) can be easily modified to fit your needs.
```shell
bash prop-pack.bash groovy/groovy-spring java/gradle-spring java/maven-spring
```
> :warning: **Make sure to use bash 4.0+** with `prop-pack.bash` as it relies on associative arrays for reading from property files.

Notice how the GCP builder is able to detect what files contain the configuration for each language/run-time and appropriately 
build and test the application before creating our application Docker image. 


Finally, we can provision our Kubernetes resources using the manifests provided:
```shell
kubectl apply -f kube
```

After a moment, we can validate that our services are running using the Docker images created with basic curl commands:
```shell
curl localhost:8000/groovy/health
curl localhost:8001/java/gradle/health
curl localhost:8002/java/maven/health
curl localhost:8003/python/health
```

## Afterwards
This is just a taste of the power of Buildpacks. I encourage you play around with different pack options, buildpacks, and builders! <br>
When you've had your fill of pre-made buildpacks, [try making your own](https://buildpacks.io/docs/buildpack-author-guide/create-buildpack/). <br>
The possibilities with Buildpacks are standard-shattering, and bring about a new way of tackling some really troublesome problems. 
Reach out if you have any questions/concerns about this example project. Looking forward to what we'll build, together.



## Reference Documentation

* [Official Buildpack Documentation](https://buildpacks.io/docs/)
* [Pack Installation](https://buildpacks.io/docs/tools/pack/)
* [Google Cloud Platform general builder](https://github.com/GoogleCloudPlatform/buildpacks)
* [k3d](https://k3d.io/) 
* [prop-pack.bash unmodified source code](https://gist.github.com/dsm0014/c31ed0109a2d0da4956f7c1561bc1ef5)