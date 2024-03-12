BUILDER_TAG ?= nri-$(INTEGRATION)-builder

.PHONY : ci/deps
ci/deps:
	@echo "===> $(INTEGRATION) ===  [ci/prerelease] TAG env variable expected to be set"

.PHONY : ci/debug-container
ci/debug-container: ci/deps
	@echo "===> $(INTEGRATION) ===  [ci/prerelease] TAG env variable expected to be set"

.PHONY : ci/test
ci/test: ci/deps
	@echo "===> $(INTEGRATION) ===  [ci/prerelease] TAG env variable expected to be set"

.PHONY : ci/build
ci/build: ci/deps
	@echo "===> $(INTEGRATION) ===  [ci/prerelease] TAG env variable expected to be set"

.PHONY : ci/prerelease
ci/prerelease: ci/deps
	@echo "===> $(INTEGRATION) ===  [ci/prerelease] TAG env variable expected to be set"