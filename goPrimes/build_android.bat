@echo off

rem Set ANDROID_SDK and NDK_BIN paths
set ANDROID_SDK=%USERPROFILE%\AppData\Local\Android\Sdk\

set NDK_BIN=%ANDROID_SDK%\ndk\27.0.11718014\toolchains\llvm\prebuilt\windows-x86_64\bin\

set OUT_PATH = ../android/app/src/main/jniLibs

rem Build for arm64
echo Building for arm64...
set CGO_ENABLED=1
set GOOS=android
set GOARCH=arm64
set CC=%NDK_BIN%\aarch64-linux-android35-clang
go build -buildmode=c-shared -o ../android/app/src/main/jniLibs/arm64-v8a/libprimego.so

rem Build for armeabi-v7a
echo Building for armeabi-v7a...
set CGO_ENABLED=1
set GOOS=android
set GOARCH=arm
set GOARM=7
set CC=%NDK_BIN%\armv7a-linux-androideabi35-clang.cmd
go build -buildmode=c-shared -o ../android/app/src/main/jniLibs/armeabi-v7a/libprimego.so

rem Build for x86
echo Building for x86...
set CGO_ENABLED=1
set GOOS=android
set GOARCH=386
set CC=%NDK_BIN%\i686-linux-android35-clang.cmd
go build -buildmode=c-shared -o ../android/app/src/main/jniLibs/x86/libprimego.so

rem Build for x86_64
echo Building for x86_64...
set CGO_ENABLED=1
set GOOS=android
set GOARCH=amd64
set CC=%NDK_BIN%\x86_64-linux-android35-clang.cmd
go build -buildmode=c-shared -o ../android/app/src/main/jniLibs/x86_64/libprimego.so

echo Done!
pause