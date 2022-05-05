RELEASE_VERSION = v1.2
VERSION = latest

OPTIONS = \
	--build-arg http_proxy=${http_proxy} \
	--build-arg https_proxy=${https_proxy} \
	--build-arg ftp_proxy=${ftp_proxy} \
	--build-arg no_proxy=${no_proxy}

build: FORCE
	docker build -t jam7/fzn-or-tools:${VERSION} ${OPTIONS} .

release: FORCE
	docker build -t jam7/fzn-or-tools:${RELEASE_VERSION} ${OPTIONS} .

push: FORCE
	docker push jam7/fzn-or-tools:${RELEASE_VERSION}
	docker push jam7/fzn-or-tools:${VERSION}

run: FORCE
	docker run --init -it --rm jam7/fzn-or-tools sh

FORCE:

