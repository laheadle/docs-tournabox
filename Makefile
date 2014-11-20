all:
	stog src -d site --tmpl src/.stog/templates/
	cp -rf site/* ~/Downloads/tournabox 
