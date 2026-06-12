.PHONY: build clean force-build run test lint preview version deploy feature fix hotfix commit release deliver

PROJECT_NAME ?= project

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

deploy: build
ifndef VERSION
	$(error VERSION is required. Usage: make deploy VERSION=0.2.0)
endif
	git checkout master
	git merge --no-ff v$(VERSION) -m "Merge tag 'v$(VERSION)'"
	~/.make/scripts/angular/deploy.sh
	git checkout -

feature:
ifndef NAME
	$(error NAME is required. Usage: make feature NAME=new-feature-name)
endif
	git checkout -b feat/$(NAME) develop

fix:
ifndef NAME
	$(error NAME is required. Usage: make fix NAME=new-feature-name)
endif
	git checkout -b fix/$(NAME) develop

hotfix:
ifndef VERSION
	$(error VERSION is required. Usage: make hotfix VERSION=0.2.1)
endif
	git checkout -b hotfix/v$(VERSION) master

commit:
	git add .
ifdef MESSAGE
	git commit -m $(MESSAGE)
else
	git commit
endif

release: version
ifndef VERSION
	$(error VERSION is required. Usage: make deploy VERSION=0.2.0)
endif
	git add package.json package-lock.json
	git commit -m "chore(release): Release v$(VERSION)"
	git tag -a v$(VERSION) -m "v$(VERSION)"

deliver:
	@CURRENT_BRANCH=$$(git branch --show-current); \
	if [ "$$CURRENT_BRANCH" = "develop" ]; then \
		echo "Already on develop"; \
		exit 1; \
	fi; \
	if [ "$$CURRENT_BRANCH" = "master" ]; then \
		echo "Cannot deliver from master"; \
		exit 1; \
	fi; \
	git checkout develop && \
	git merge --no-ff "$$CURRENT_BRANCH" -m "Merge branch '$$CURRENT_BRANCH'" && \
	git branch -d "$$CURRENT_BRANCH"
	git push
