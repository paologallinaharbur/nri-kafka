WORKDIR      := $(shell pwd)
TARGET       := target
TARGET_DIR    = $(WORKDIR)/$(TARGET)
NATIVEOS	 := $(shell go version | awk -F '[ /]' '{print $$4}')
NATIVEARCH	 := $(shell go version | awk -F '[ /]' '{print $$5}')
INTEGRATION  := kafka
BINARY_NAME   = nri-$(INTEGRATION)
GO_PKGS      := $(shell go list ./... | grep -v "/vendor/")
GO_FILES     := ./src/
GOFLAGS       = -mod=readonly

all: build

build: clean test compile

generate:
	@echo "=== $(INTEGRATION) === [ generate ]: Generating mocks..."

clean:
	@echo "=== $(INTEGRATION) === [ clean ]: Removing binaries and coverage file..."

compile:
	@echo "=== $(INTEGRATION) === [ compile ]: Building $(BINARY_NAME)..."

test:
	@echo "=== $(INTEGRATION) === [ test ]: running unit tests..."

integration-test:
	@echo "=== $(INTEGRATION) === [ test ]: running integration tests..."

POD_NAME  := agent
NAMESPACE := test-kafka
ARGS := ""
# run an agent pod with "kubectl run   agent --image newrelic/infrastructure-bundle --env="LICENSE_KEY=...."
run-on-pod:
	GOOS=linux GOARCH=amd64

# rt-update-changelog runs the release-toolkit run.sh script by piping it into bash to update the CHANGELOG.md.
# It also passes down to the script all the flags added to the make target. To check all the accepted flags,
# see: https://github.com/newrelic/release-toolkit/blob/main/contrib/ohi-release-notes/run.sh
#  e.g. `make rt-update-changelog -- -v`
rt-update-changelog:
	curl "https://raw.githubusercontent.com/newrelic/release-toolkit/v1/contrib/ohi-release-notes/run.sh"

# Include thematic Makefiles
include $(CURDIR)/build/ci.mk
include $(CURDIR)/build/release.mk

.PHONY: all build clean compile test rt-update-changelog
