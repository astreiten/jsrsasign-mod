.PHONY: all

FILES_MIN = \
	min/asn1-1.0.min.js \
	min/asn1hex-1.1.min.js \
	min/asn1x509-1.0.min.js \
	min/asn1cms-1.0.min.js \
	min/asn1tsp-1.0.min.js \
	min/asn1cades-1.0.min.js \
	min/asn1csr-1.0.min.js \
	min/asn1ocsp-1.0.min.js \
	min/base64x-1.1.min.js \
	min/crypto-1.1.min.js \
	min/ecdsa-modified-1.0.min.js \
	min/ecparam-1.0.min.js \
	min/dsa-2.0.min.js \
	min/keyutil-1.0.min.js \
	min/rsapem-1.1.min.js \
	min/rsasign-1.2.min.js \
	min/x509-1.1.min.js \
	min/jws-3.3.min.js \
	min/jwsjs-2.0.min.js \
	min/x509crl.min.js \
	min/nodeutil-1.0.min.js

JSDOC_SRC = \
	asn1hex-1.1.js \
	rsapem-1.1.js \
	rsasign-1.2.js \
	x509-1.1.js \
	keyutil-1.0.js \
	asn1-1.0.js \
	asn1x509-1.0.js \
	asn1cms-1.0.js \
	asn1tsp-1.0.js \
	asn1cades-1.0.js \
	asn1csr-1.0.js \
	asn1ocsp-1.0.js \
	crypto-1.1.js \
	ecdsa-modified-1.0.js \
	ecparam-1.0.js \
	dsa-2.0.js \
	base64x-1.1.js \
	jws-3.3.js \
	jwsjs-2.0.js \
	x509crl.js \
	nodeutil-1.0.js

FILES_EXT_MIN = \
	ext/ec-min.js \
	ext/rsa-min.js \
	ext/rsa2-min.js

JSRUN=jsrun-jsrsasign.sh

JSDOCOUTDIR1=_tmp

APIDOCDIR=api

all-min: $(FILES_MIN)
	@echo "all min converted."

all-ext-min: $(FILES_EXT_MIN)
	@echo "all ext min converted."

min/%.min.js: src/%.js
	yui-compressor $^ -o $@

ext/%-min.js: ext/%.js
	yui-compressor $^ -o $@

all: join-main

join-minify: *min.js ext/*min.js npm/lib/header.js npm/lib/footer.js
	cat *min.js $(shell find ext/ -name "*min.js") | sed "s/\/*! /\n\/*! /g" > jsrsasign-4.9.0-mdcone-all-min.js
	cp jsrsasign-4.9.0-mdcone-all-min.js jsrsasign-latest-all-min.js

#min-js: *.js
#	for i in `ls *.js | grep -v "min.js"` ; do java -jar ~/src/yuicompressor/build/yuicompressor-2.4.8.jar $i -o `echo $i | sed 's/.js/-min.js/g'` ; done

join-main: join-minify
	cat \
        npm/lib/header.js \
        jsrsasign-latest-all-min.js \
        npm/lib/footer.js \
        > npm/lib/jsrsasign.js

gitadd-release:
	git add ChangeLog.txt Makefile bower.json jsrsasign-*-min.js min/*.js src/*.js npm/package.json npm/lib/jsrsasign*.js npm/lib/{header,footer,lib}.js src/*.js test/qunit-do-*.html test/x509crl.html README.md npm/README.md tool/*.html npm_util/*.* npm_util/lib/*.* npm/test/t_*.js

gitadd: gitadd-release
	@echo done