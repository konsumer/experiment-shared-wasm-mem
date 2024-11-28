// Import the host function
@external("null0", "host_function_that_takes_string_param")
declare function host_function_that_takes_string_param(text: string): void;

// Export the cart function that modifies memory
export function cartFunction(ptr: i32, length: i32): void {
  const data = new Int32Array(length);
  for (let i = 0; i < length; i++) {
    data[i] = load<i32>(ptr + i * 4) + 1;
    store<i32>(ptr + i * 4, data[i]);
  }
}

// Export the function that sends a string to host
export function send_request_to_host(): void {
  host_function_that_takes_string_param("Cool!");
}
