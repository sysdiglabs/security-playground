# Security Playground

The security playground is a HTTP web server to simulate security breaches in
run time.

## Installation

Use the docker image to deploy it in your Kubernetes cluster

```bash
$ kubectl apply -f k8s-deployment.yaml
```

Or run it locally in a using docker

```bash
$ docker run --rm -p 8080:8080 sysdiglabs/security-playground
```

## Usage

The HTTP API exposes three endpoints to interact with the system.

### Reading a file

You can read a file using just the URL.

```bash
$ curl localhost:8080/etc/shadow
```

This will return the content of the /etc/shadow file.

### Writing a file

You can write to a file using the URL and POSTing the content.

```bash
$ curl -X POST localhost:8080/bin/hello -d 'content=hello-world'
```

This will write to /bin/hello the hello-world string

### Executing a command

You can execute a command using the /exec endpoint and POSTing the command.

```bash
$ curl -X POST /exec -d 'command=ls -la'
```

This will capture and return the STDOUT of the command executed.

### Interactive Menu

Or for some quick testing try the sec-playground-menu.sh bash script

```bash
$ ./sec-playground-menu.sh 
What is the http address of your target? [http://192.168.1.59]: 

Select an Exploit:
1) Read Sensitive File
2) Write script to /tmp
3) Exec bad script
4) Run Port Scan
5) Dump Environment Variables
6) Install PSQL Tools
7) Dump DB
8) Exfiltrate Data
0) Exit
Choose an option: 
```
