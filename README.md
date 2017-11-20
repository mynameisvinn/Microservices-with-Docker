# what is this?
the simplest microservices example, running a flask container and a mongodb container.

## what happens when you run docker-compose up? ##
running `docker-compose up` kicks off a sequence of events.

#### 1) docker-compose yml ####
the docker daemon starts with `docker-compose.yml`. this file describes which docker images to pull (eg mongodb), how to configure containers (ports, volumes, etc.), and dependencies (eg web links with db).

#### 2) get image, run container ####
for each service (`web` and `db` in this example), docker fetches the appropriate image and then runs it as a container. 

lets examine the **web** image in closer detail.
```
FROM dataquestio/python3-starter
ADD . /todo
WORKDIR /todo

# include "--user" since containers are not sudo
RUN pip install --user -r requirements.txt
```
this **dockerfile** fetches `dataquestio/python3-starter`, a base image, from [dockerhub](https://hub.docker.com/r/dataquestio/python3-starter/). it then adds contents from the current directory to the container's `todo` folder. finally, from this newly created web container, it installs `requirements`.

#### 3) configure container ####
docker configures containers according to `docker-compose.yml`. going back to the `web` service, this means a few things:
* **entrypoint**. run `python app.py`, thereby lauching the web service. 
* **ports**. map web container's port 5000 to localhost:5001.
* **volumes**. sync host's current folder with container's todo folder.
* **links**. declare web's dependency to the `db` service. docker compose handles this.

#### 4) done ####
thats it. go to `http://localhost:5000` to see your mini microservice in action.