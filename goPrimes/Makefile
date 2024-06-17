
ANDROID_SDK=$(HOME)/Library/Android/sdk

NDK_BIN=$(ANDROID_SDK)/android-ndk-r26d/toolchains/llvm/prebuilt/linux-x86_64/bin


android-arm64:
	CGO_ENABLED=1 \
	GOOS=android \
	GOARCH=arm64 \
	CC=$(NDK_BIN)/aarch64-linux-android21-clang \
	go build -buildmode=c-shared -o libout/libprimez-arm64.so

android-x86:
	CGO_ENABLED=1 \
    	GOOS=android \
    	GOARCH=386 \
    	CC=$(NDK_BIN)/i686-linux-android21-clang \
    	go build -buildmode=c-shared -o libout/libprimez-x86.so

android-x86_64:
	CGO_ENABLED=1 \
    	GOOS=android \
    	GOARCH=amd64 \
    	CC=$(NDK_BIN)/x86_64-linux-android21-clang \
    	go build -buildmode=c-shared -o libout/libprimez-x86_64.so

android:  android-arm64 android-x86 android-x86_64