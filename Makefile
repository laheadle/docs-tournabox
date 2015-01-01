# The publishing process here is as follows. We have two versions of
# the web site: The "dev" and "release" versions

# They are located at:
# https://laheadle.github.io/docs-tournabox/dev
# and
# https://laheadle.github.io/docs-tournabox/release

# We can regularly change the dev site as we build new versions, but
# the release site only changes when we create a new release.

# To build a development (unstable) version, run
# make stability=dev version=my.version.num

# To build a release (stable) version, run
# make stability=release version=my.version.num

# To specify an output directory, Set the environment variable
# TOURNABOX_TESTDIR

# -- WARNING -- TOURNABOX_TESTDIR will be cleared and the generated
# web site will be copied there.


templates=src/.stog/templates
data=$(templates)/data

versionFileName=$(data)/version.txt

# contains the string "dev" or "release"
# used by the web site to construct its own base file name
stabilityFileName=$(data)/stability.txt

outDir=./$(stability)

all: setVersion setStability checkTestDir getTournabox
	echo -n $(stability) > $(stabilityFileName)
	rm -rf $(outDir)
	stog src -d $(outDir) --tmpl $(templates)
	rm -rf $(TOURNABOX_TESTDIR)/*
	cp -rf * $(TOURNABOX_TESTDIR)

checkTestDir:
ifeq ($(TOURNABOX_TESTDIR),)
	echo "please set the env variable TOURNABOX_TESTDIR to the directory where your test site will end up"
	exit 1
else
	echo -n $(version) > $(versionFileName)
endif

setVersion:
ifeq ($(version),)
	echo "no version given!"
	exit 1
else
	echo -n $(version) > $(versionFileName)
endif

setStability:
ifeq ($(stability),)
	echo "no stability given!"
	exit 1
else
	echo -n $(stability) > $(stabilityFileName)
endif

getTournabox:
	cp `ocamlfind query tournabox`/tournabox.js src/js
	cp `ocamlfind query tournabox`/tournabox.css src/css

