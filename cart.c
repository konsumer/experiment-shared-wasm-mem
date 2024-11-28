#include <stdint.h>

__attribute__((import_module("null0"), import_name("host_function_that_takes_string_param")))
void host_function_that_takes_string_param(char* text);

__attribute__((export_name("cartFunction")))
void cartFunction(int32_t* data, size_t length) {
    // Example function that manipulates shared memory
    for (size_t i = 0; i < length; i++) {
        data[i] += 1;
    }
}

__attribute__((export_name("send_request_to_host")))
void send_request_to_host() {
  host_function_that_takes_string_param("Cool!");
}
