build/fmt: build fmt/*.pony
	ponyc fmt -o build --debug

build:
	mkdir build

test: build/fmt
	build/fmt

clean:
	rm -rf build

.PHONY: clean test
