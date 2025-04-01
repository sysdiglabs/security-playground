# Security Playground

![last commit](https://flat.badgen.net/github/last-commit/sysdiglabs/security-playground?icon=github) ![licence](https://flat.badgen.net/github/license/sysdiglabs/security-playground) ![docker pulls](https://flat.badgen.net/docker/pulls/sysdiglabs/security-playground?icon=docker)

The security playground is an HTTP web server to simulate security breaches. It allows you to read, write, and execute commands in a containerized environment.


## Build

```
$ docker build -t sysdiglabs/security-playground:latest .
```


## Installation

Deploy the docker image in your environment, and setup the probe health check to the `/health:8080` endpoint if required.

You can also run the image locally:

```bash
$ docker run --rm -p 8080:8080 sysdiglabs/security-playground
```


## Usage

The application provides endpoints for:
 - [Health checks](#health-checks)
 - [Reading file](#reading-a-file)
 - [Writing file](#writing-a-file)
 - [Executing commands](#executing-a-command)


### Health checks

The health check endpoint is `/health` on port `8080` and returns the `200` HTTP status code.


### Reading a file

You can retrieve a file's contents by sending a `GET` request to the application's URL.

```bash
$ curl <URL>:8080/<PATH>
```

For example:

```bash
$ curl localhost:8080/etc/shadow
```

This will return the content of the `/etc/shadow` file in the container running locally.



### Writing a file

You can write data to a file by sending a `POST` request to the application's URL with the desired content.

```bash
$ curl -X POST <URL>:8080/<PATH> -d 'content=<CONTENT>'
```

For example:

```bash
$ curl -X POST localhost:8080/bin/hello -d 'content=hello-world'
```

This command writes the string hello-world to /bin/hello.



### Executing a command

To execute a command, send a `POST` request to the `/exec` endpoint with the command as the payload.

```bash
$ curl -X POST <URL>:8080/exec -d 'command=<CMD>'
```

For example:

```bash
$ curl -X POST localhost:8080/exec -d 'command=ls'
```

This will run the command and return its STDOUT output.
