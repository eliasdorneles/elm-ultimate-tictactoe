watch:
	find src/ | grep elm | entr elm-make --output=app.js --debug src/Main.elm 
