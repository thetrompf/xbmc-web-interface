define [
	"base/viewmodel"
	"text!app/home/templates/home.html"
	"text!app/home/templates/inner.html"
], (ViewModelBase, template) ->
	'use strict'
	class HomeViewModel extends ViewModelBase

		bindingContext: "#main-container"
		template: template
		template = null
		self = null
