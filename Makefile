# Compiler paths and tools
EMCC = emcc
WASI_CLANG = /opt/wasi-sdk/bin/clang

# Output files
HOST_OUTPUT = docs/host.mjs
CART_OUTPUT = docs/cart.wasm

# Source files
HOST_SOURCES = host.c
CART_SOURCES = cart.c

# Emscripten flags for host
EMCC_FLAGS = \
  -s SINGLE_FILE \
	-s EXPORTED_RUNTIME_METHODS='["ccall","cwrap","wasmMemory"]' \
	-s EXPORTED_FUNCTIONS='["_malloc","_free"]' \
	-s ALLOW_MEMORY_GROWTH=1 \
	-s MODULARIZE=1 \
	-s SHARED_MEMORY=1 \
	-s INITIAL_MEMORY=16777216 \
	-s MAXIMUM_MEMORY=67108864

# Debug flags for Emscripten (uncomment when debugging)
#EMCC_DEBUG_FLAGS = -g4 -s ASSERTIONS=2 -s SAFE_HEAP=1

# WASI flags for cart
WASI_FLAGS = \
	--target=wasm32-wasi \
	-nostdlib \
	-nodefaultlibs \
	-mbulk-memory \
	-matomics \
	-mthread-model single \
	-Wl,--import-memory \
	-Wl,--export-all \
	-Wl,--no-entry \
	-Wl,--shared-memory \
	-Wl,--max-memory=67108864

# Debug flags for WASI (uncomment when debugging)
#WASI_DEBUG_FLAGS = -g -dwarf-version=4

# Default target
all: $(HOST_OUTPUT) $(CART_OUTPUT)

# Build host module
$(HOST_OUTPUT): $(HOST_SOURCES)
	$(EMCC) $(HOST_SOURCES) -o $(HOST_OUTPUT) $(EMCC_FLAGS) $(EMCC_DEBUG_FLAGS)

# Build cart module
$(CART_OUTPUT): $(CART_SOURCES)
	$(WASI_CLANG) $(CART_SOURCES) -o $(CART_OUTPUT) $(WASI_FLAGS) $(WASI_DEBUG_FLAGS)

# Clean build files
clean:
	rm -f $(HOST_OUTPUT) $(HOST_OUTPUT).map
	rm -f $(CART_OUTPUT)

.PHONY: all clean
