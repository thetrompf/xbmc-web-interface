define [
	'jquery'
	'knockout'
	'bootstrap'
], ($, ko) ->
	class Application

		constructor: (args) ->
			console.log 'Initializing Application'