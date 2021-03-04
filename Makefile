name=sia-container
version=1.5.5

default: alpine

alpine:
	docker build --file alpine/Dockerfile \
		--build-arg SIA_VERSION=$(version) \
		-t $(name) -t esurdam/sia:alpine-$(version) -t esurdam/sia:alpine-latest \
		.

stop:
	docker stop $(docker ps -a -q --filter "name=$(name)") && docker rm $(docker ps -a -q --filter "name=$(name)")

.PHONY: default alpine stop