requirejs.config
	baseUrl: '/js'
	paths: 
		jquery: "vendor/jquery/jquery"
		knockout: "vendor/knockout/knockout"
		underscore: "vendor/underscore/underscore"
		bootstrap: "vendor/bootstrap/bootstrap-all"
		sammy: "vendor/sammy/sammy"
	shim: 
		underscore:
			exports: "_"
		knockout:
			exports: "ko"
		jquery:
			exports: "jQuery"
		sammy:
			deps: ["jquery"]
			exports: "Sammy"

require ["app/app", "jquery", "knockout", "sammy", "underscore"], (Application, $, ko, Sammy, _) ->
	new Application()