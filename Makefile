all:
	cp tournabox/tournabox.js src/js
	cp tournabox/tournabox.css src/css
	stog src -d . --tmpl src/.stog/templates/
	cp -rf * ~/Downloads/docs-tournabox 

submodules:
	git submodule foreach git pull
