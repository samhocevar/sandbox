
CLANG32 = /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++
CLANG31 = /usr/bin/clang++

CXXFLAGS = -O2 -I. -arch armv7 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS6.1.sdk

all: file.cpp
	@echo "### Building with clang++ 3.1"
	$(CLANG31) $(CXXFLAGS) $^ -c -o with31.o
	@echo
	@echo "### Building with clang++ 3.2"
	$(CLANG32) $(CXXFLAGS) $^ -c -o with32.o

clean:
	rm -f *.o*

