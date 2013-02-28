
SDK = /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer
CXXFLAGS = -O2 -arch armv7 -isysroot $(SDK)/SDKs/iPhoneOS6.1.sdk

all:
	@echo "Warning: this is probably going to eat all your memory and fill your disk."
	@echo "Type \"make fuckyeah\" if you are sure."

fuckyeah:
	$(SDK)/usr/bin/g++ $(CXXFLAGS) -c file.cpp -o file.o

