# android_ Kotlin vs Dart vs Rust Vs Wasm

A project written to test performace of the languages Kotlin, Dart, Rust and Wasm on android app by getting how many times a language can get total number prime numbers between a range, in 5 seconds, got the idea from [Dave's Garage on Youtube](https://www.youtube.com/watch?v=D3h62rgewZM)



## Build requirements:

- Rust 1.69+
- Flutter 3.x+

- cargo-ndk. Can be installed via cargo with:

  ```sh
  cargo install cargo-ndk
  ```

  

## Running

First compile the rust library, then move it to jniLibrary dir of android file using cargo-ndk

```sh
cargo ndk -t armeabi-v7a -t arm64-v8a -t x86_64 -t x86 --no-strip -o ./android/app/src/main/jniLibs build --release
```

Run the flutter app

```sh
flutter run
```

or build

```sh
flutter build
```

