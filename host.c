#include <emscripten.h>
#include <stdint.h>

EMSCRIPTEN_KEEPALIVE void hostFunction(int32_t* data, size_t length) {
  // Example function that manipulates shared memory
  for (size_t i = 0; i < length; i++) {
      data[i] *= 2;
  }
}
