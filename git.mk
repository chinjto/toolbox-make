.PHONY: deploy feature fix hotfix commit release deliver

DEPLOY_SCRIPT ?= ~/not-defined

deploy: build
ifndef VERSION
	$(error VERSION is required. Usage: make deploy VERSION=0.2.0)
endif
	git checkout master
	git merge --no-ff v$(VERSION) -m "Merge tag 'v$(VERSION)'"
	$(DEPLOY_SCRIPT)
	git push
	git checkout -

feature:
ifndef NAME
	$(error NAME is required. Usage: make feature NAME=new-feature-name)
endif
	git checkout -b feat/$(NAME) develop
	git push -u origin feat/$(NAME)

fix:
ifndef NAME
	$(error NAME is required. Usage: make fix NAME=new-feature-name)
endif
	git checkout -b fix/$(NAME) develop
	git push -u origin fix/$(NAME)

hotfix:
ifndef VERSION
	$(error VERSION is required. Usage: make hotfix VERSION=0.2.1)
endif
	git checkout -b hotfix/v$(VERSION) master
	git push -u origin hotfix/$(NAME)

commit:
	git add .
ifdef MESSAGE
	git commit -m "$(MESSAGE)"
else
	git commit
endif
	git push

release: version
ifndef VERSION
	$(error VERSION is required. Usage: make deploy VERSION=0.2.0)
endif
	git add .
	git commit -m "chore(release): Release v$(VERSION)"
	git push
	git tag -a v$(VERSION) -m "v$(VERSION)"
	git push -u origin v$(VERSION)

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
	git push
	git branch -d "$$CURRENT_BRANCH"
	git push -d origin "$$CURRENT_BRANCH"
