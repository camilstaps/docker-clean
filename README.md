# docker-clean

Dockerfiles for [Clean](http://clean.cs.ru.nl).

## Available tags

* `latest`, `2.4-stable` (Linux 64-bit, 'stable release' without iTasks but
  with a development version of `clm` to support hierarchical module names)
* `nightly` (includes an `install_clean.sh` script which can be used to get a
  nightly for a specific date` - see below how to derive a Dockerfile for this)

`camilstaps/clean:base` is a bootstrap container and should not be used
separately.

## How to use

Simply run `clm`:

```Dockerfile
docker run -v /my/.../directory:/root camilstaps/clean clm MainModule
```

Deriving a new Dockerfile:

```Dockerfile
FROM camilstaps/clean:2.4-stable
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN clm MainModule -o MainModule
CMD ["./MainModule"]
```

Deriving a new Dockerfile with a nightly:

```Dockerfile
FROM camilstaps/clean:nightly
RUN install_clean.sh bundle-complete 2017-10-03
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN apt-get update -qq &&\
	apt-get install --no-install-recommends -qq gcc &&\
	clm MainModule -o MainModule &&\
	apt-get remove --purge -qq gcc &&\
	apt-get autoremove --purge -qq &&\
	&& rm -rf /var/lib/apt/lists
CMD ["./MainModule"]
```

## Source code

[github.com/camilstaps/docker-clean](https://github.com/camilstaps/docker-clean)

## Docker Hub

[hub.docker.com/r/camilstaps/clean](https://hub.docker.com/r/camilstaps/clean)
