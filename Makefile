all: join-main

join-minify: *min.js ext/*min.js npm/lib/header.js npm/lib/footer.js
	cat *min.js $(shell find ext/ -name "*min.js") | sed "s/\/*! /\n\/*! /g" > jsrsasign-4.9.0-mdcone-all-min.js
	cp jsrsasign-4.9.0-mdcone-all-min.js jsrsasign-latest-all-min.js

join-main: join-minify
	cat \
        npm/lib/header.js \
        jsrsasign-latest-all-min.js \
        npm/lib/footer.js \
        > npm/lib/jsrsasign.js