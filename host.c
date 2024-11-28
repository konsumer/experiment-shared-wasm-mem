#include <emscripten.h>
#include <stdint.h>
#include <stdio.h>

// this is called externally, in host, to test if the memory is modified
EMSCRIPTEN_KEEPALIVE void hostFunction(int32_t* data, size_t length) {
  for (size_t i = 0; i < length; i++) {
      data[i] *= 2;
  }
}

// this is called by cart directly (from host-binding)
EMSCRIPTEN_KEEPALIVE void host_function_that_takes_string_param(char* text) {
  printf("HOST: cart sent me %s\n", text);
}
