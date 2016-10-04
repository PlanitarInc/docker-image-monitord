# XXX no versioning of the docker image
IMAGE_NAME=planitar/monitord

ifneq ($(NOCACHE),)
  NOCACHEFLAG=--no-cache
endif

.PHONY: build push clean test

build:
	docker build ${NOCACHEFLAG} -t ${IMAGE_NAME} .

push:
ifneq (${IMAGE_TAG},)
	docker tag ${IMAGE_NAME} ${IMAGE_NAME}:${IMAGE_TAG}
	docker push ${IMAGE_NAME}:${IMAGE_TAG}
else
	docker push ${IMAGE_NAME}
endif

clean:
	docker rmi -f ${IMAGE_NAME} || true

test:
	docker run -d --name test-monitord ${IMAGE_NAME} \
	  /usr/sbin/collectd -ftT
	sleep 1
	logs=`docker logs test-monitord`; \
	     echo $$logs; \
	  test -z "$$logs" || echo $$logs >&2; \
	  docker rm -f test-monitord; \
	  test -z "$$logs"
