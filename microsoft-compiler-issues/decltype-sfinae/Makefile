
all: build-gcc build-clang

build-gcc: decltype-sfinae.cpp
	g++ -std=c++11 $^ -o $@

build-clang: decltype-sfinae.cpp
	clang++ -std=c++11 $^ -o $@

clean:
	rm -f build-gcc build-clang *.exe

