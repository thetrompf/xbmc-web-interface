define [
	"jquery"
	"underscore"
	"knockout"
	"sammy"
	"app/routes"
], ($, _, ko, Sammy, routes) ->
	class Application

		router: null
		activeMainViewModel: null

		constructor: (args) ->
			console.log "Initializing Application"
			@initRouter()

		initRouter: () ->
			that = @
			@router = Sammy () ->
				initRoute = (url, path) =>
					path = that.parsePath path
					@get url, () ->
						require ["app/#{path.module}/#{path.viewmodel}"], (VM) ->
							that.activeMainViewModel?.dispose?()
							vm = new VM
							that.activeMainViewModel = vm
							vm[path.method]() if path.method? and _.isFunction vm[path.method]
							ko.applyBindings vm
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