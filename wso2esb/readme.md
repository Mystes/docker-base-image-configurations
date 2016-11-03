To build a either of the jdk-slim images run:

```docker build -t mystes/wso2esb:<image-tag> -f ./<image-tag>/Dockerfile .```

So to build ```5.0.0-jdk-8u112-slim``` you'd run:

```docker build -t mystes/wso2esb:5.0.0-jdk-8u112-slim -f ./5.0.0-jdk-8u112-slim/Dockerfile .```

Further usage instructions can be found from [readme-dockerhub.md](readme-dockerhub.md).
