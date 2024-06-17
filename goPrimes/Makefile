
ANDROID_SDK=$(HOME)/Library/Android/sdk

NDK_BIN=$(ANDROID_SDK)/android-ndk-r26d/toolchains/llvm/prebuilt/linux-x86_64/bin
ANDROID_OUT=../android/app/src/main/jniLibs


android-arm64:
	CGO_ENABLED=1 \
	GOOS=android \
	GOARCH=arm64 \
	CC=$(NDK_BIN)/aarch64-linux-android21-clang \
	go build -buildmode=c-shared -o $(ANDROID_OUT)/arm64-v8a/libprimego.so

android-armeabi-v7a:
	CGO_ENABLED=1 \
	GOOS=android \
	GOARCH=arm \
	GOARM=7 \
	CC=$(NDK_BIN)/armv7a-linux-androideabi21-clang \
	go build -buildmode=c-shared -o $(ANDROID_OUT)/armeabi-v7a/libprimego.so

android-x86:
	CGO_ENABLED=1 \
    	GOOS=android \
    	GOARCH=386 \
    	CC=$(NDK_BIN)/i686-linux-android21-clang \
    	go build -buildmode=c-shared -o $(ANDROID_OUT)/x86/libprimego.so

android-x86_64:
	CGO_ENABLED=1 \
    	GOOS=android \
    	GOARCH=amd64 \
    	CC=$(NDK_BIN)/x86_64-linux-android21-clang \
    	go build -buildmode=c-shared -o $(ANDROID_OUT)/x86_64/libprimego.so

android:  android-arm64 android-x86 android-x86_64 android-armeabi-v7a