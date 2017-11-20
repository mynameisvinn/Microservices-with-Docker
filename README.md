## what is this?
the simplest microservices example, running a flask container and a mongodb container.

## what happens when you run docker-compose up?
running `docker-compose up` kicks off a sequence of events.

### 1) docker-compose yml ###
the docker daemon will start with `docker-compose.yml`. the yaml file describes which docker images to pull (eg mongodb), how to configure (container:5000 maps to host:5001), and service links (depends on mongodb services).

### 2) get image, run container ###
for each named service (`web` and `db` in this example), docker will pull the appropriate image and then run it as a container according to specified configurations. 

lets examine the **web** image in closer detail.
```
FROM dataquestio/python3-starter
ADD . /todo
WORKDIR /todo

# include "--user" since containers are not sudo
RUN pip install --user -r requirements.txt
```
this **dockerfile** will pull `dataquestio/python3-starter`, a base image, from [dockerhub](https://hub.docker.com/r/dataquestio/python3-starter/). it will then add contents from the current directory to the container's `todo` folder. finally, from this newly created web container, it will pip install `requirements`.

### 3) configure container ###
docker will now configure this container according to `docker-compose.yml`. this means a few things:
* **entrypoint**. run `python app.py`, thereby lauching the web service. 
* **ports**. map container's port 5000 to localhost:5001.
* **volumes**. sync host's current folder with container's todo folder.
* **links**. declare web service's dependency to the `db` service. docker compose handles this.

### 4) done ###
thats it. go to `http://localhost:5000` to see your mini microservice in action.