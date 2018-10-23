

CXXFLAGS = -Os -g -ggdb -Wall -Wextra

all: compress

clean:
	rm -f compress

compress: compress.cpp
	$(CXX) $(CXXFLAGS) $^ -o $@

