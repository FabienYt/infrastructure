### Tasks
check_update:
	docker run -it -e DOCKER_TASK="check_update" -v ${CURDIR}/ansible:/ansible:rw -v ${CURDIR}/data:/data:ro ansible_infrastructure

configure:
	docker run -it -e DOCKER_TASK="configure" -v ${CURDIR}/ansible:/ansible:rw -v ${CURDIR}/data:/data:ro ansible_infrastructure

deploy:
	docker run -it -e DOCKER_TASK="deploy" -v ${CURDIR}/ansible:/ansible:rw -v ${CURDIR}/data:/data:ro ansible_infrastructure

preseed:
	docker run --privileged -it -e DOCKER_TASK="preseed" -v ${CURDIR}/ansible:/ansible:rw -v ${CURDIR}/data:/data:rw ansible_infrastructure

update:
	docker run -it -e DOCKER_TASK="update" -v ${CURDIR}/ansible:/ansible:rw -v ${CURDIR}/data:/data:ro ansible_infrastructure

update_vm_applications:
	docker run -it -e DOCKER_TASK="update" -e DOCKER_LIMIT="vm-esxi-applications" -v ${CURDIR}/ansible:/ansible:rw -v ${CURDIR}/data:/data:ro ansible_infrastructure

update_vm_network:
	docker run -it -e DOCKER_TASK="update" -e DOCKER_LIMIT="vm-esxi-network" -v ${CURDIR}/ansible:/ansible:rw -v ${CURDIR}/data:/data:ro ansible_infrastructure

### Setup
build:
	docker build -q -t ansible_infrastructure -f docker/Dockerfile .

lint:
	docker run -it -e DOCKER_TASK="lint" -v ${CURDIR}/ansible:/ansible:rw ansible_infrastructure

ping:
	docker run -it -e DOCKER_TASK="ping" -v ${CURDIR}/ansible:/ansible:rw -v ${CURDIR}/data:/data:ro ansible_infrastructure

vault:
	docker run -it -e DOCKER_TASK="vault" -v ${CURDIR}/ansible:/ansible:rw ansible_infrastructure
