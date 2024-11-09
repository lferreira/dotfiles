# Configuration
user-nick = $(USER)
golang-version = $(GO_VERSION)

.PHONY : osx/install
osx/install:
	./install.sh

.PHONY : osx/install/password-manager
osx/install/password-manager:
	./install_password_manager.sh

.PHONY : osx/update
osx/update:
	./update.sh

.PHONY : pre-commit
pre-commit:
	pre-commit run --all-files
