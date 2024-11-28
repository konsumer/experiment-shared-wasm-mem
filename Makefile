# Compiler paths and tools
EMCC = emcc
WASI_CLANG = /opt/wasi-sdk/bin/clang

HOST_SOURCES = host.c
HOST_OUTPUT = docs/host.mjs

CART_SOURCES = cart.c
CART_OUTPUT = docs/cart.wasm

CART2_SOURCES = cart2.ts
CART2_OUTPUT = docs/cart2.wasm

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

# Default target
all: $(HOST_OUTPUT) $(CART_OUTPUT) $(CART2_OUTPUT)

# Build host module
$(HOST_OUTPUT): $(HOST_SOURCES)
	$(EMCC) $(HOST_SOURCES) -o $(HOST_OUTPUT) $(EMCC_FLAGS) $(EMCC_DEBUG_FLAGS)

# Build cart module
$(CART_OUTPUT): $(CART_SOURCES)
	$(WASI_CLANG) $(CART_SOURCES) -o $(CART_OUTPUT) $(WASI_FLAGS) $(WASI_DEBUG_FLAGS)

# Clean build files
clean:
	rm -f $(HOST_OUTPUT) $(CART_OUTPUT) $(CART2_OUTPUT)

$(CART2_OUTPUT): $(CART2_SOURCES)
	npx asc $(CART2_SOURCES) \
    --importMemory \
    --initialMemory 16 \
    --maximumMemory 65536 \
    --noExportMemory \
    --sharedMemory \
    --runtime stub \
    --importTable \
    --optimize \
    --noAssert \
    --enable threads \
    --target release \
    -o $(CART2_OUTPUT)

serve:
	npx -y live-server docs

.PHONY: all clean serve
