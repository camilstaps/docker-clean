# docker-clean

Dockerfiles for [Clean](http://clean.cs.ru.nl).

## Available tags

* `stable`, `2.4-stable` (Linux 64-bit, 'stable release' without iTasks)
* `latest`, `itasks`, `2.4-itasks`, `2.4-itasks-20160531` (Linux 64-bit,
	'development release' with iTasks)

All containers use `camilstaps/clean:base`. This is a bootstrap container and
should not be used separately.

## How to use

Simply run `clm`:

```
docker run -v /my/.../directory:/root camilstaps/clean MainModule
```

  
Deriving a new Dockerfile:

```
FROM camilstaps/clean:2.4-stable
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN clm MainModule -o MainModule
CMD ["./MainModule"]
```

## Source code

[github.com/camilstaps/docker-clean](https://github.com/camilstaps/docker-clean)

## Docker Hub

[hub.docker.com/r/camilstaps/clean](https://hub.docker.com/r/camilstaps/clean)
