.PHONY : osx/install

# Configuration
user-nick = $(USER)
golang-version = $(GO_VERSION)

osx/install:
	./install.sh

.PHONY : pre-commit
pre-commit:
	pre-commit run --all-files
