# docker-clean

Dockerfiles for [Clean](http://clean.cs.ru.nl).

## Available tags

* `stable`, `2.4`, `2.4-stable` (Linux 64-bit, 'stable release' without iTasks)
* `itasks`, `2.4-itasks`, `2.4-itasks-20161024` (Linux 64-bit, 'development
  release' with iTasks)
* `latest`, `itasks-latest`, `2.4-itasks-latest` (same as `itasks`, but with
  `clean-platform` from git)
* `nightly` (includes an `install_clean.sh` script which can be used to get a
  nightly for a specific date` - see below how to derive a Dockerfile for this)

### Old tags

* `2.4-itasks-20160531` (like `2.4-itasks-20161024` but using an old release)

All images use `camilstaps/clean:base`. This is a bootstrap container and
should not be used separately.

All images use a development version of `clm`, which supports hierarchical
module names.

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

These images are based on Debian Stretch with GCC 6, which means that you will
usually have to add `-l -no-pie` to the `clm` options.

The nightly is on Debian Jessie, so it is not necessary there. Deriving a new
Dockerfile with a nightly:

```Dockerfile
FROM camilstaps/clean:nightly
RUN install_clean.sh bundle-complete 2017-10-03
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN clm MainModule -o MainModule
CMD ["./MainModule"]
```

## Source code

[github.com/camilstaps/docker-clean](https://github.com/camilstaps/docker-clean)

## Docker Hub

[hub.docker.com/r/camilstaps/clean](https://hub.docker.com/r/camilstaps/clean)
