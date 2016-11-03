# WSO2 ESB

These images contain WSO2 ESB with an emphasis on ease of development and (image) extension.

###### Available Versions:
* ```5.0.0-jdk-8u112-slim``` (latest)
* ```5.0.0-jdk-8u102-slim```
* ```5.0.0```
* ```4.9.0```
* ```4.8.1```

**NOTE**

The following documentation **only** applies to tags incorporating the JDK version, currently ```latest``` (```5.0.0-jdk-8u112-slim```) and ```5.0.0-jdk-8u102-slim```.

### Usage

The simplest way to launch an ESB container is to run:

```docker run -it -p 9443:9443 mystes/wso2esb```

This command only exposes the ESB management console port.

By default the images file systems are entirely stateless. That means that upon reboot you will lose any changes you've made to the container environment.

### Directories

For your convenience, several ESB directories are made available at the file system root. The directories are:
* /config -> $ESB_HOME/repository/conf
* /carbonapps -> $ESB_HOME/repository/deployment/server/carbonapps
* /deploy -> /repository/deployment/server/synapse-configs

The ```/deploy``` directory is special. If you provide a non-empty volume for it, the volume is expected to contain the necessary files for the ESB to boot (namely ```synapse.xml```). If the provided volume is empty, it is copied over with ESB default content for the directory so that the ESB will successfully boot.

### Persisting Data

The way to make these directories persistent is to use Docker volumes. You have two options. You can have Docker automatically manage the volumes or you can mount the volumes to a directory on the host machine. Docker run commands for doing the two are as follows:

To have Docker automatically manage the volumes for you run:

```docker run -it -v /carbonapps -v /deploy mystes/wso2esb```

To map the volumes to host directories yourself run:

```docker run -it -v $(pwd)/esb/carbonapps:/carbonapps -v $(pwd)/esb/deploy:/deploy mystes/wso2esb```

### Deploying Carbon Applications

As usual, there are three ways of deploying carbonapps the first one being the most preferred.
1. Copy the .car file into the carbonapps directory
2. Maven deployment
3. Deploy via the management console (cumbersome)

Process for the first one includes adding specifying a volume using a host directory. To map a host directory to a container directory run the image with:

```docker run -it -v $(pwd)/esb/carbonapps:/carbonapps mystes/wso2esb```

You can then copy your .car file directory to the mapped directory on the host (here: ```$(pwd)/esb/carbonapps```).

### Configuration

The config directory is mostly provided with the ease of extensibility in mind.

There is no special handling for the ```/config``` directory (as opposed to ```/deploy```). If you mount a volume on top of it, you will have to provide all required ESB config files yourself. If you wish to replace one of the default config files, the recommended approach is to create a new Docker image ```FROM```ing from this one and replacing the required file when building the image.

In some cases it makes sense to map only some or none of the volumes.

The following ports are exposed:

| Port | Purpose |
|---|---|
| 9443 | ESB management console (HTTPS) |
| 9763 | ESB HTTP servlet port (required for tryit) |
| 8280 | ESB HTTP services |
| 8243 | ESB HTTPS services |

Several environment variables, which may be of interest, are also present. These are:

| Variable | Purpose | Default |
|---|---|---|
| JAVA_OPTS | Startup options for the ESB JVM | -Xmx2048m -XX:MaxPermSize=512m -Dfile.encoding=UTF-8 |
| WSO2_ESB_HOME | ESB root directory | /opt/wso2-esb-$VERSION |
| ESB_CONFIG_DIR | Location of the ESB config files | /config |
| ESB_CARBONAPPS_DIR | Directory where the ESB stores its deployed .car files | /carbonapps |
| ESB_DEPLOY_DIR | Directory where the ESB stores its deployed artifacts | /deploy |
