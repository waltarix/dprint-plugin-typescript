TARGET := wasm32-unknown-unknown
RELEASE_SUFFIX := -$(TARGET)
export CARGO_BUILD_TARGET = $(TARGET)

PROJECT_NAME := dprint_plugin_typescript

VERSION := $(subst $\",,$(word 3,$(shell grep -m1 "^version" Cargo.toml)))
RELEASE := $(PROJECT_NAME)-$(VERSION)$(RELEASE_SUFFIX)

DIST_DIR := dist

BINARY := target/$(TARGET)/release/$(PROJECT_NAME).wasm

RELEASE_BINARY := $(DIST_DIR)/plugin.wasm

.PHONY: all
all: $(RELEASE_BINARY)

$(BINARY):
	cargo build --locked --release --features wasm

$(DIST_DIR):
	mkdir -p $@

$(RELEASE_BINARY): $(BINARY) $(DIST_DIR)
	cp -f $< $@

.PHONY: clean
clean:
	$(RM) -r $(RELEASE_BINARY) $(DIST_DIR)
