# XXX no versioning of the docker image

.PHONY: build push clean test

build:
	docker build -t planitar/monitord .

push:
	docker push planitar/monitord

clean:
	docker rmi -f planitar/monitord || true

test:
	docker run -d --name test-monitord planitar/monitord \
	  /usr/sbin/collectd -ftT
	sleep 1
	logs=`docker logs test-monitord`; \
	     echo $$logs; \
	  test -z "$$logs" || echo $$logs >&2; \
	  docker rm -f test-monitord; \
	  test -z "$$logs"
