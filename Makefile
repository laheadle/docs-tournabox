all:
	cp tournabox/tourney.js src/js
	stog src -d site --tmpl src/.stog/templates/
	cp -rf site/* ~/Downloads/tournabox 

submodules:
	git submodule foreach git pull
