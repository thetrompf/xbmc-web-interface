define [
	"jquery"
	"underscore"
	"knockout"
	"sammy"
	"app/routes"
	"base/viewmodel"
], ($, _, ko, Sammy, routes, ViewModelBase) ->
	class TopmenuViewModel extends ViewModelBase

	class Application

		# Holds the Sammy.js router.
		router: null
		# The current active main view model.
		activeViewModel: null
		# The current active path.
		activePath: {}

		# observable, that holds the url
		url: null

		constructor: (args) ->
			@url = ko.observable()
			@initRouter()

		initRouter: () ->
			that = @
			@router = Sammy () ->
				initRoute = (url, path) =>
					path = that.parsePath path

					@get url, () ->
						if that.activePath.module is path.module and that.activePath.viewmodel is path.viewmodel
							that.url url
							that.activePath = path
							that.activeViewModel[path.method]() if path.method? and _.isFunction that.activeViewModel[path.method]
							return @

						require ["app/#{path.module}/#{path.viewmodel}"], (VM) ->
							
							that.activeViewModel?.dispose?()

							vm = new VM url: that.url
							that.activeViewModel = vm
							that.activePath = path
							that.url url

							bindingContext = null
							if _.isFunction vm.bindingContext
								bindingContext = vm.bindingContext()
							else if _.isString vm.bindingContext
								bindingContext = bc[0] if (bc = $(vm.bindingContext)).length > 0
							else if vm.bindingContext instanceof $
								bindingContext = vm.bindingContext[0]

							throw new Error "Body has been selected as binding context, due to nu other valid context has been given" unless bindingContext?

							vm[path.method]() if path.method? and _.isFunction vm[path.method]
							ko.applyBindings vm, bindingContext
							vm.bindingsApplied()

				for r in routes
					if _.isString r.url
						initRoute r.url, r.path
					else if _.isArray r.url
						for u in r.url
							initRoute u, r.path
				return @
			.run()

		parsePath: (path) ->
			p = path.split '#'
			p[1] = "viewmodel" unless p[1]?
			throw new Error "Invalid router path #{path}" unless p[0]? and p[1]?
			return {
				module: p[0]
				viewmodel: p[1]
				method: p[2]
			}