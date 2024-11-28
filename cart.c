#include <stdint.h>

__attribute__((export_name("cartFunction")))
void cartFunction(int32_t* data, size_t length) {
    // Example function that manipulates shared memory
    for (size_t i = 0; i < length; i++) {
        data[i] += 1;
    }
}
