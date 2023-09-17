import 'dart:ffi';

typedef PrimesFFI = Int64 Function(Int64 a);
typedef Primes = int Function(int a);

int rustPrimes(int end) {
  final lib = DynamicLibrary.open('libprimes.so');
  final primes = lib
      .lookup<NativeFunction<PrimesFFI>>("get_primes_over_time")
      .asFunction<Primes>();
  return primes(end);
}
