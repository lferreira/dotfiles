.PHONY : osx/install

# Configuration
user-nick = $(USER)
golang-version = $(GO_VERSION)

osx/install:
	./install.sh
