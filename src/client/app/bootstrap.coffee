requirejs.config
	baseUrl: '/js'
	paths:
		jquery: "vendor/jquery/jquery-1.9.0"
		knockout: "vendor/knockout/knockout-2.2.0"
		underscore: "vendor/underscore/underscore-1.4.3"
		bootstrap: "vendor/bootstrap/bootstrap-all"
		sammy: "vendor/sammy/sammy-0.7.2"
		text: "vendor/require/require.text-2.0.3"
		xbmc: "app/lib/xbmc"
		date: "app/lib/date"
		"knockout-postbox": "vendor/knockout-postbox/knockout-postbox-0.3.0"
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

require ["app/app", "jquery", "knockout", "sammy", "underscore", "text", "knockout-postbox"], (Application, $, ko, Sammy, _) ->
	new Application()
