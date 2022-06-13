### Tasks

configure:
	docker run -it -e DOCKER_TASK="configure" -v ${CURDIR}/ansible:/ansible:rw -v ${CURDIR}/data:/data:ro ansible_infrastructure

deploy:
	docker run -it -e DOCKER_TASK="deploy" -v ${CURDIR}/ansible:/ansible:rw -v ${CURDIR}/data:/data:ro ansible_infrastructure

preseed:
	docker run --privileged -it -e DOCKER_TASK="preseed" -v ${CURDIR}/ansible:/ansible:rw -v ${CURDIR}/data:/data:rw ansible_infrastructure

### Setup
build:
	docker build -q -t ansible_infrastructure -f docker/Dockerfile .

lint:
	docker run -it -e DOCKER_TASK="lint" -v ${CURDIR}/ansible:/ansible:rw ansible_infrastructure

ping:
	docker run -it -e DOCKER_TASK="ping" -v ${CURDIR}/ansible:/ansible:rw -v ${CURDIR}/data:/data:ro ansible_infrastructure

vault:
	docker run -it -e DOCKER_TASK="vault" -v ${CURDIR}/ansible:/ansible:rw ansible_infrastructure
