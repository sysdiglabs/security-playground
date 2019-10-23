docker: build push

build:
	docker build -t sysdiglabs/security-playground .

push:
	docker push sysdiglabs/security-playground
