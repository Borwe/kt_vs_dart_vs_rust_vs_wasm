import 'dart:ffi';

typedef PrimesFFI = Int64 Function(Int64 a);
typedef Primes = int Function(int a);

int goPrimes(int end) {
  final lib = DynamicLibrary.open('libprimego.so');

  final primes = lib
      .lookup<NativeFunction<PrimesFFI>>("getPrimesOverTime")
      .asFunction<Primes>();

  return primes(end);
}