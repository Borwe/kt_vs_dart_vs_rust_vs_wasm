# android_ Kotlin vs Dart vs Rust Vs Wasm

A project written to test performance of the languages Kotlin, Dart, Rust, Wasm and Go on android app by getting how many times a language can get total number prime numbers between a range, in 5 seconds, got the idea from [Dave's Garage on Youtube](https://www.youtube.com/watch?v=D3h62rgewZM)



## Build requirements:

- Rust 1.69+
- Flutter 3.x+
- go 1.22+

## build rust shared library

- cargo-ndk. Can be installed via cargo with:

  ```sh
  cargo install cargo-ndk
  ```
- install the necessary toolchains for different android architectures
  ```shell
  rustup target add aarch64-linux-android 
  rustup target add armv7-linux-androideabi 
  rustup target add x86_64-linux-android 
  rustup target add i686-linux-android
   ```
  

### Running

First compile the rust library, then move it to jniLibrary dir of android file using cargo-ndk
switch to the rust directory and run:

```sh
cargo ndk -t armeabi-v7a -t arm64-v8a -t x86_64 -t x86 --no-strip -o ../android/app/src/main/jniLibs build --release
```
## Build golang shared library

To build the shared libraries for different Android architectures, change into the goPrimes directory and run the bat file for windows
or the Makefile for unix systems,ensure that the ndk paths are set correctly.

batch for windows
```bash
build_android.bat
````

Makefile for unix 
```sh
make android
```

## Run the flutter app

```sh
flutter run
```

or build

```sh
flutter build
```

