# docker-clean

Dockerfiles for [Clean](http://clean.cs.ru.nl).

## Available tags

* `2.4-stable` (2011 stable release, without iTasks but with a development
  version of `clm` to support hierarchical module names)
* `3.0-stable` (2018 stable release, without iTasks)
* `nightly` (includes an `install_clean.sh` script which can be used to get a
  nightly for a specific date` - see below how to derive a Dockerfile for this)
* `latest` is an alias for the latest stable release, currently `3.0-stable`

## How to use

### `clm`

```Dockerfile
docker run -v /my/.../directory:/usr/src/app camilstaps/clean clm MainModule
```

### Deriving a new Dockerfile

This builds a docker image in which `MainModule` is built and then run.

```Dockerfile
FROM camilstaps/clean:2.4-stable
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN clm MainModule -o MainModule
CMD ["./MainModule"]
```

### Deriving a new Dockerfile with a nightly

This builds a docker image in which `MainModule` is built and then run.
By combining the `[un]install_clean.sh` and the `clm` calls in one `RUN`
command, we save space in the Docker cache.

```Dockerfile
FROM camilstaps/clean:nightly
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN install_clean.sh bundle-complete 2017-10-03 &&\
	clm MainModule -o MainModule &&\
	uninstall_clean.sh
CMD ["./MainModule"]
```

## Source code

[github.com/camilstaps/docker-clean](https://github.com/camilstaps/docker-clean)

## Docker Cloud

[cloud.docker.com/repository/docker/camilstaps/clean](https://cloud.docker.com/repository/docker/camilstaps/clean)

## Building new images

To build new images, the following steps should be performed:

```bash
docker build -t camilstaps/clean:base base
docker build -t camilstaps/clean:2.4-stable 2.4-stable
docker build -t camilstaps/clean:3.0-stable 3.0-stable
docker build -t camilstaps/clean:nightly nightly
docker tag camilstaps/clean:3.0-stable camilstaps/clean
```

Optionally, push these to the Docker Cloud:

```bash
docker push camilstaps/clean
docker push camilstaps/clean:2.4-stable
docker push camilstaps/clean:3.0-stable
docker push camilstaps/clean:nightly
```

Do not push `camilstaps/clean:base`. It is only meant as a generic base image
for the other images.
