# First, install tournabox using opam

# The publishing process here is as follows. We have two "global"
# (world-visible) versions of the web site: The "stable" and
# "unstable" versions.

# They are located at:
# https://laheadle.github.io/docs-tournabox/stable
# and
# https://laheadle.github.io/docs-tournabox/unstable

# We can regularly change the unstable site as we build new versions, but
# the stable site only changes when we create a new release.

# To build an unstable version, run
# make stability=unstable version=my.version.num

# To build a stable (release) version, run
# make stability=stable version=my.version.num

# For development, we have a "local" version, on localhost.

# To build the local version, set the environment variable
# TOURNABOX_TESTDIR to the path where your local web server will serve
# the site from; Make sure it is called docs-tournabox.

# then run:
# make local-pages

# -- WARNING -- TOURNABOX_TESTDIR will be cleared and the generated
# web site will be copied there.


templates=src/.stog/templates
data=$(templates)/data

# Contains a root url and path for the "global" built site. The
# stability will be appended to yield the final base url/path
# (a.k.a. the stog site-url).
globalRoot=https://laheadle.github.io/docs-tournabox

# Contains a root url and path for the "local" built site.
localRoot=http://localhost/docs-tournabox

# contains a version number, like 1.0.0
versionFileName=$(data)/version.txt

outDir=./$(stability)

### interface

gh-pages: setVersion checkStability getTournabox
	rm -rf $(outDir)
	stog src -d $(outDir) --site-url $(globalRoot)/$(stability) --tmpl $(templates)

local-pages: build-local
	cp `ocamlfind query tournabox`/tournabox.js $(TOURNABOX_TESTDIR)/js
	cp `ocamlfind query tournabox`/tournabox.css $(TOURNABOX_TESTDIR)/css


### Implementation

build-local: checkTestDir
	echo -n "local" > $(versionFileName)
	rm -rf $(TOURNABOX_TESTDIR)/*
	stog src -d $(TOURNABOX_TESTDIR)/ --site-url $(localRoot) --tmpl $(templates)

checkTestDir:
ifeq ($(TOURNABOX_TESTDIR),)
	echo "please set the env variable TOURNABOX_TESTDIR to the directory where your test site will end up"
	exit 1
endif

setVersion:
ifeq ($(version),)
	echo "no version given!"
	exit 1
else
	echo -n $(version) > $(versionFileName)
endif

checkStability:
ifeq ($(stability),)
	echo "no stability given!"
	exit 1
endif

getTournabox:
	cp `ocamlfind query tournabox`/tournabox.js src/js
	cp `ocamlfind query tournabox`/tournabox.css src/css


