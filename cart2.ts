// Import the host function
@external("null0", "host_function_that_takes_string_param")
declare function host_function_that_takes_string_param(text: ArrayBuffer): void;

// Export the cart function that modifies memory
export function cartFunction(ptr: i32, length: i32): void {
  // Direct memory access using load/store
  for (let i = 0; i < length; i++) {
    const offset = ptr + (i << 2); // multiply by 4 because Int32
    const value = load<i32>(offset);
    store<i32>(offset, value + 1);
  }
}

// Export the function that sends a string to host
export function send_request_to_host(): void {
  // Create a string in shared memory
  host_function_that_takes_string_param(String.UTF8.encode("I am cart2!", true));
}
