NAME = nick4fake/kubernetes-reverseproxy
VERSION = 0.0.3

.PHONY: all build push tag_latest release

all: build

build:
	docker build -t $(NAME):$(VERSION) .

push:
	docker push $(NAME):$(VERSION)

tag_latest:
	docker tag -f $(NAME):$(VERSION) $(NAME):latest

release: build test tag_latest
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME)
	@echo "*** Don't forget to run 'twgit release/hotfix finish' :)"
