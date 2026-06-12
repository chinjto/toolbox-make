.PHONY: build clean force-build run test lint preview version deploy

PROJECT_NAME ?= project
DEPLOY_SCRIPT = ~/.make/scripts/angular/deploy.sh

include ~/.make/git.mk

build:
	npm run build

clean:
	rm -rf dist
	rm -rf .angular/cache

force-build: clean build

run:
	npm start

test:
	npm test

lint:
	npm run lint

preview: build
	cd dist/$(PROJECT_NAME)/browser && python3 -m http.server 8080

version:
	npm version $(VERSION) --no-git-tag-version
