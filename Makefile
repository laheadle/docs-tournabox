all:
	cp tournabox/tourney.js src/js
	stog src -d . --tmpl src/.stog/templates/
	cp -rf * ~/Downloads/docs-tournabox 

submodules:
	git submodule foreach git pull
