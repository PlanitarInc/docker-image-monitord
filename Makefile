# XXX no versioning of the docker image

.PHONY: build push clean

build:
	docker build -t planitar/monitord .

push:
	docker push planitar/monitord

clean:
	docker rmi -f planitar/monitord || true
