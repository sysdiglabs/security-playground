docker: build push

build:
	docker build -t fernii/security-playground:2.0-root -f Dockerfile .
	docker build -t fernii/security-playground:2.0-user -f Dockerfile.user .

push:
	docker push fernii/security-playground:2.0-root
	docker push fernii/security-playground:2.0-user
