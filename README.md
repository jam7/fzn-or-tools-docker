# fzn-or-tools-docker

A docker container to run fzn-or-tools as a host user.

## Prerequisite

Need to install docker.

## Install

Download container and run it to generate kindlegen script.

```
$ docker pull jam7/fzn-or-tools
$ docker run --rm jam7/fzn-or-tools > fzn-or-tools
$ chmod a+x fzn-or-tools
```

Don't add `-it` to `docker run`.  Otherwise, your fzn-or-tools script may
contain crlf.

## How to use it

Use a generated fzn-or-tools script as a regular fzn-or-tools.

```
$ ./fzn-or-tools test.fzn
```

## Build

In order to build image by yourself, perform `make`

```
$ make
```

## License

@ 2022 Kazushi (Jam) Marukawa, All rights reserved.

Distributed under the terms of the Apache License 2.0.
See `LICENSE` for more information.

## Related projects

OR-Tools is available at https://github.com/google/or-tools
