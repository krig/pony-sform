build/sform: build sform/*.pony
	ponyc sform -o build --debug

build:
	mkdir build

test: build/sform
	build/sform

clean:
	rm -rf build

.PHONY: clean test
