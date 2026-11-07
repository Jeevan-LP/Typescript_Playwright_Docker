# Docker Notes

> Docker · Virtualization · Containerization · Commands · Compose · Volumes

---

## Contents

1. [Docker](#docker)
2. [Virtualization](#virtualization)
3. [Containerization](#containerization)
4. [Difference between Virtualization and Containerization](#difference-between-virtualization-and-containerization)
5. [Docker basic commands](#docker-basic-commands)
6. [Images commands](#images-commands)
7. [Container commands](#container-commands)
8. [System commands](#system-commands)
9. [Compose commands](#compose-commands)
10. [Push and Pull commands](#push-and-pull-commands)
11. [Docker port mapping](#docker-port-mapping)
12. [Docker volume](#docker-volume)
13. [Dockerfile and docker-compose.yml difference](#dockerfile-and-docker-composeyml-difference)
14. [Topics list](#topics-list)

---

## Docker

Docker is a platform used to create, package, and run applications in single isolated containers.

---

## Virtualization

Virtualization is the process of creating virtual computers or resources on a physical machine using hypervisor.
if we install hypervisor software, we can use multiple operating system in single host machine

```text
Hard ware--> Host OS--> Hypervisor----------> VM1(Guest OS like Linux, apps)
                                        |
                                        |---> VM2(Guest OS like Window, apps)
                                        |
                                        |---> VM2(Guest OS like Mac OS, apps)
```

---

## Containerization

Containerization is the process of packaging an application with its dependencies and configuration into an isolated, lightweight container so it can run consistently across environments.

```text
Hard ware--> Host OS--> Container Engine----------> CONTAINER1(Application, files and libraries)
                                              |
                                              |---> CONTAINER2(Application, files and libraries)
                                              |
                                              |---> CONTAINER3(Application, files and libraries)
```

---

## Difference between Virtualization and Containerization

| Virtualization | Containerization |
|---|---|
| VM rubs on its own OS | Containers runs host OS |
| Preallwocation of resource | No preallwocation of resource |
| Creates virtual machines | Creates containers |
| VM has a complete guest OS | Container doesn't have a complete guest OS |
| More resource-intensive | Lightweight |
| Usually slower to start | Usually starts quickly |
| Example: VirtualBox VM | Example: Docker container |
| VM can run a different OS | Containers typically share the underlying kernel |

---

## Docker basic commands

| # | Command | Description |
|---|---|---|
| 1 | `docker --version` | Shows only the Docker version. |
| 2 | `docker version` | Shows both Client and Server/Engine versions. |
| 3 | `docker -v` | Shows the installed Docker version. |
| 4 | `docker info` | Shows containers, images, storage driver, CPUs, memory, Docker root directory, etc. |
| 5 | `docker --help` | Shows available Docker commands and their usage. |
| 6 | `docker login` | Authenticates your Docker account so you can pull/push private images and push your images to a registry. |

---

## Images commands

| # | Command | Description |
|---|---|---|
| 1 | `docker images` | listing images which are downloaded |
| 2 | `docker pull <<image name>>` | pull/download the images |
| 3 | `docker rmi <<image id>>` | remove the images |
| 4 | `docker build -t <image name> .` | to create/build images |
| 5 | `docker run --rm <image name>` | it will run and delete the container |
| 6 | `docker run <image name>` | it will run without delete the container |

---

## Container commands

| # | Command | Description |
|---|---|---|
| 1 | `docker ps` | listing all running containers |
| 2 | `docker run <<image name>>` | create a container using image name(if image is exist). if image is not exist it will pull the image and create the container |
| 3 | `docker start <<container id>>` | start the container |
| 4 | `docker stop <<container id>>` | stop the container |
| 5 | `docker rm <<container id/name>>` | remove the container |

---

## System commands

| Command | Description |
|---|---|
| `docker stats` | display all images and container |
| `docker system df` | display all images and container |
| `docker system prune -f` | remove all containers |

---

## Compose commands

| # | Purpose | Command |
|---|---|---|
| 1 | Run all tests | `docker compose run --rm <container-name>` |
| 2 | Run all tests explicitly | `docker compose run --rm <container-name> all` |
| 3 | Run sanity tests | `docker compose run --rm <container-name> sanity` |
| 4 | Run regression tests | `docker compose run --rm <container-name> regression` |
| 5 | Run web UI tests | `docker compose run --rm <container-name> web` |
| 6 | Run API tests | `docker compose run --rm <container-name> api` |
| 7 | Run master suite | `docker compose run --rm <container-name> master` |
| 8 | Run end-to-end tests | `docker compose run --rm <container-name> e2e` |
| 9 | Run data-driven tests | `docker compose run --rm <container-name> datadriven` |

### Only if there is a docker-compose.yml and docker-entrypoint.sh files

| # | Command | Description |
|---|---|---|
| 1 | `docker compose build` | Build the image |
| 2 | `docker compose run --rm <<docker service name from docker-compose.yml>>` | Run tests in a container |
| 3 | `docker compose up --build` | Build and run in one step |
| 4 | `docker images` | List your images |
| 5 | `docker rmi <<image name/id>>` | Remove an image |

### Only if there is no docker-compose.yml and docker-entrypoint.sh files

| # | Command | Description |
|---|---|---|
| 1 | `docker build -t <<give image name as your want>> .` | Build new docker image |
| 2 | `docker images` | List docker images |
| 3 | `docker rmi <<image id>>` | Remove the images |
| 4 | `docker run --rm <<docker image name/id which given by you>>` | Run the test with creating container. And delete after execution. |
| 5 | `docker run <<docker image name/id which given by you>>` | Run the test with creating container. And it doesn't delete after execution. also we can execute in side docker as well |
| 6 | `docker ps` | listing all running containers |
| 7 | `docker rm <<container id/name>>` | Remove the running container |

---

## Push and Pull commands

### a. Push

1. `docker login` : Authenticates your Docker account so you can pull/push private images and push your images to a registry.
2. `docker tag <image name> <dockerhub-username>/<image name>:<tag>`
3. `docker push <dockerhub-username>/<image name>:<tag>`

### b. Pull

1. `docker pull <dockerhub-username>/<image name>:<tag>`
2. `docker run <image name>`

---

## Docker port mapping

We need port mapping when you want to access an application running inside a Docker container from outside the container, such as from your browser or another application on your Windows machine.

| Step | Command | Note |
|---|---|---|
| a | `docker run -d nginx` | need to pull nginx images |
| b | `docker run -d -p 80:80 nginx` | create port number |
| c | `http://localhost/` | Open this URL |

---

## Docker volume

### a. Named volume

A named volume is storage managed by Docker that is stored separately from the container and can persist even after the container is deleted. Use a named volume when you want Docker to manage persistent data.

**Commands:**

| # | Command | Description |
|---|---|---|
| 1 | `docker volume create <volume name>` | create a name volume |
| 2 | `docker volume ls` | list all volume which are defined |
| 3 | `docker volume inspect <volume name>` | Show the detailed information |
| 4 | `docker run --name <conatiner name> -v <volume name>:/app/data <image name>` | data written inside the container is stored in Docker-managed storage |
| 5 | `docker volume rm <volume name>` | it delete the volume. before we need to delete container |

### b. Bind volume

A bind mount maps a specific folder or file from the host machine directly to a folder or file inside the container. Use a bind mount when you want the container to directly access files on your computer.

### b. tmpfs mount

A tmpfs mount stores temporary data in the host's memory (RAM) instead of persistent disk storage.

---

## Dockerfile and docker-compose.yml difference

| File | What it does |
|---|---|
| **a. Dockerfile** | installs Playwright, copies your tests and sets the default command. This is what is inside the image. |
| **b. docker-compose.yml** | gives the container its name, environment variables and volumes for reports. This is how it runs. |

**c. One-line answer for an interview:**

> "A Dockerfile defines how to build an image, and Docker Compose defines how to run and configure containers, such as volumes, environment variables and multiple services, with a single command."

---

## Topics list

- Docker vs VM
- Image vs Container
- Dockerfile
- FROM, COPY, RUN, CMD, ENTRYPOINT
- docker build
- docker run
- docker ps
- docker exec
- .dockerignore
- Port mapping
- Environment variables
- Docker + Playwright
- Headless vs headed execution
- Xvfb
- VNC/noVNC
- Docker + Jenkins
- Docker troubleshooting
- Docker reports/volumes
- localhost vs host.docker.internal
- Your actual Docker Playwright project explanation