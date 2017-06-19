# IoTivity-in-a-box

## Introduction
The objective behind this experiment is to provide a very quick and easy way for folks to use [iotivity-node], the JavaScript bindings for [IoTivity]. The only requirement is to have [Docker] installed on your machine.

## How to use the `IoTivity-in-a-box` container
### Running a simple JavaScript application
Here are a few steps that will get you going with the `IoTivity-in-a-box` container:
1. Install [Docker] if not yet available on your system (follow [these instructions](https://docs.docker.com/engine/installation/) if you need help with this step).
2. Prepare a project space where you will have your [node.js] application JavaScript file that uses [iotivity-node].

If you don't have one yet, you can grab one of our example following these steps (Linux command-line):
```
$ mkdir ~/test/
$ cd ~/test
$ wget https://raw.githubusercontent.com/01org/SmartHome-Demo/master/ocf-servers/js-servers/gas.js
```

3. Run it with the Docker image
```
$ sudo docker run -v `pwd`:/opt/user gvancuts/iotivity-in-a-box gas.js
```
**Note:** this container only works on x86 CPU architectures.

You now have an OCF server (gas/CO2 detector) running on your local machine!! If you’re not sure how to easily verify this, take a look at [this section](#using-the-iot-rest-api-server-in-a-container) below.

The **generic form** for using the `IoTivity-in-a-box` container is the following:
```
$ sudo docker run -v `pwd`:/opt/user gvancuts/iotivity-in-a-box <your-app.js>
```
Where `your-app.js` is your [node.js] application that uses [iotivity-node].

### How to handle extra application dependencies
The [IoTivity-in-a-box] container also supports installing additional applications dependencies if a `package.json` file is provided. In order to use this feature, simply create your own `package.json` file in your project space (e.g. `test` as used above) and it will automatically be detected by the container and a `npm install` will be executed inside the container.

### Using the [IoT REST API Server] in a container
A very easy and neat way to check what OIC/OCF servers are available in your network is to use a containerized version of the [IoT REST API Server].
1. Install the [IoT REST API Server] container
```
$ sudo docker pull smarthome2cloud/smarthome-gateway
```

2. Run the container (aka gateway)
There are different ways you can run such container, they all work so feel free to pick your preferred method. If you wish to get a better understanding of what these really mean and how they work, I recommend you read this section about [networking in Docker](https://docs.docker.com/engine/userguide/networking/).
    1. Using the host network
    ```
    $ sudo docker run --net host smarthome2cloud/smarthome-gateway
    ```
    2. Mapping the container port to a host port
    ```
    $ sudo docker run -p 8000:8001 smarthome2cloud/smarthome-gateway
    ```
    3. Using the standard `bridge` network from Docker
    ```
    $ sudo docker run smarthome2cloud/smarthome-gateway
    ```

3. Open a web browser and use the following URLs
    1. When using the host network, go to: http://localhost:8000/api/oic/res
    2. When mapping the container port, go to: http://localhost:8001/api/oic/res
    3. When using the standard `bridge` network, go to: [http://\<ip-of-container\>:8000/api/oic/res]()

**Hint:** for your convenience, the IP address of the container is printed at the very beginning.

[node.js]: https://nodejs.org/
[IoTivity]: https://www.iotivity.org/
[iotivity-node]: https://www.npmjs.com/package/iotivity-node
[IoTivity-in-a-box]: https://hub.docker.com/r/gvancuts/iotivity-in-a-box/
[Docker]: https://www.docker.com/
[IoT REST API Server]: https://github.com/01org/iot-rest-api-server
