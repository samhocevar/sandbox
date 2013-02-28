

GXX = /usr/bin/g++
LLVMGXX = /usr/bin/llvm-g++
CLANGXX = /usr/bin/clang++

all: file.cpp
	@echo "### Building with g++"
	$(GXX) $^ -c -o withgxx.o
	@echo
	@echo "### Building with llvm-g++"
	$(LLVMGXX) $^ -c -o withllvmgxx.o
	@echo
	@echo "### Building with clang++"
	$(CLANGXX) $^ -c -o withclangxx.o

clean:
	rm -f *.o*

