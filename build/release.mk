BUILD_DIR    := ./bin/
GORELEASER_VERSION := v0.174.1
GORELEASER_BIN ?= bin/goreleaser

bin:
	@mkdir -p $(BUILD_DIR)

$(GORELEASER_BIN): bin
	@echo "===> $(INTEGRATION) === [$(GORELEASER_BIN)] Installing goreleaser $(GORELEASER_VERSION)"


.PHONY : release/clean
release/clean:
	@echo "===> $(INTEGRATION) === [release/clean] remove build metadata files"


.PHONY : release/deps
release/deps: $(GORELEASER_BIN)
	@echo "===> $(INTEGRATION) === [release/deps] install goversioninfo"

.PHONY : release/build
release/build: release/deps release/clean
ifeq ($(PRERELEASE), true)
	@echo "===> $(INTEGRATION) === [release/build] PRE-RELEASE compiling all binaries, creating packages, archives"
else
	@echo "===> $(INTEGRATION) === [release/build] build compiling all binaries"
endif

.PHONY : release/fix-archive
release/fix-archive:
	@echo "===> $(INTEGRATION) === [release/fix-archive] fixing tar.gz archives internal structure"


.PHONY : release/sign/nix
release/sign/nix:
	@echo "===> $(INTEGRATION) === [release/sign] signing packages"


.PHONY : release/publish
release/publish:
	@echo "===> $(INTEGRATION) === [release/publish] publishing artifacts"

.PHONY : release
release: release/build release/fix-archive release/sign/nix release/publish release/clean
	@echo "===> $(INTEGRATION) === [release/publish] full pre-release cycle complete for nix"

OS := $(shell uname -s)
ifeq ($(OS), Darwin)
	OS_DOWNLOAD := "darwin"
	TAR := gtar
else
	OS_DOWNLOAD := "linux"
endif
