#include <emscripten.h>
#include <stdint.h>
#include <stdio.h>

EMSCRIPTEN_KEEPALIVE void hostFunction(int32_t* data, size_t length) {
  // Example function that manipulates shared memory
  for (size_t i = 0; i < length; i++) {
      data[i] *= 2;
  }
}


EMSCRIPTEN_KEEPALIVE void host_function_that_takes_string_param(char* text) {
  printf("HOST: cart sent me %s\n", text);
}
