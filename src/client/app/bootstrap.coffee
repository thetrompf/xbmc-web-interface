requirejs.config
	baseUrl: '/js'
	paths: 
		jquery: "vendor/jquery/jquery"
		knockout: "vendor/knockout/knockout"
		underscore: "vendor/underscore/underscore"
		bootstrap: "vendor/bootstrap/bootstrap-all"
	shim: 
		underscore:
			exports: "_"

require ['app/app'], (Application) ->
	new Application()