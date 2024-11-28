#include <stdint.h>

// this import comes from host wasm
__attribute__((import_module("null0"), import_name("host_function_that_takes_string_param")))
void host_function_that_takes_string_param(char* text);

// this is called externally, in host, to test if the memory is modified
__attribute__((export_name("cartFunction")))
void cartFunction(int32_t* data, size_t length) {
    for (size_t i = 0; i < length; i++) {
        data[i] += 1;
    }
}

// this is called externally, in host, to test string
__attribute__((export_name("send_request_to_host")))
void send_request_to_host() {
  host_function_that_takes_string_param("I am cart1!");
}
