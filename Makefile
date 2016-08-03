help:
	@cat Makefile

build:
	elm make Main.elm

open:
	open index.html

b: build
o: open
