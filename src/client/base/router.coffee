define [
	"jquery"
	"underscore"
	"knockout"
	"sammy"
], ($, _, ko, Sammy) ->
	###
	# The Router mixin utilizing SammyJS.
	# Most offen used in the application / the first initilized class.
	# @uses jQuery | _ | ko | Sammy
	###
	class Router

		###
		# Holds the Sammy.js router.
		# @var Sammy | null
		###
		router: null

		###
		# The current active main viewmodel.
		# @var ViewModelBase | null
		###
		activeViewModel: null

		###
		# The current active path.
		# module: String
		# viewmodel: String
		# method: String | null 
		#
		# @var Object | Empty
		###
		activePath: {}

		###
		# Observable, that holds the URL last handled by Sammy.
		# @var ko.observable<String>
		###
		url: ko.observable ""

		###
		# Initialize the router
		# @param array<routeHash> routes
		# @return Sammy
		###
		initRouter: (routes, options) ->
			that = @
			@router = Sammy () ->
				
				###
				# Initialize one url, with the action described in the path string
				# @param string url
				# @param string path
				# @return Sammy
				# @throws Error if calling a method on a viewmodel, that doesn't exist.
				###
				initRoute = (url, path, verb) =>

					# defauls verb to get.
					verb = 'get' unless verb?

					# resolving the path string to a hash
					path = that._parsePath path

					# init the url
					@route verb, url, () ->

						if that.activePath.module is path.module and that.activePath.viewmodel is path.viewmodel and not that.activeViewModel.alwaysDispose
							# chaning the url observable
							that.url url
							# setting the current activePath
							that.activePath = path

							# and calling the method on the viewmodel if defined by path or exists.
							if path.method?
								throw new Error "Couldn't find method: #{path.method} on viewmodel app/#{path.module}/#{path.viewmodel}" unless _.isFunction that.activeViewModel[path.method]
								that.activeViewModel[path.method]()
							return @

						# requires the new viewmodel
						require ["app/#{path.module}/#{path.viewmodel}"], (VM) ->
							
							# dispose the old active viewmodel
							that.activeViewModel?.dispose?()

							# unsetting old view model
							that.activeViewModel = null

							# changing the url observable
							that.url url

							# initialize the new viewmodel
							vm = new VM options

							# setting the active view model to this one.
							that.activeViewModel = vm
							
							# setting the activePath hash to the currently resolved path hash.
							that.activePath = path

							# calling the method of the of the path hash, if any is defined.
							vm[path.method]() if path.method? and _.isFunction vm[path.method]

				# setting up routes.
				for r in routes
					# if the url is a string.
					if _.isString r.url
						initRoute r.url, r.path, r.method

					# if the url is an array, apply the same method to all the urls.
					else if _.isArray r.url
						for u in r.url
							initRoute u, r.path, r.method

				# return Sammy
				return @
			.run()

		###
		# Parses a route path to an activePath hash, used internally.
		# @param string path
		# @return Object
		# @throws Error if couldn't parse the path
		###
		_parsePath: (path) ->
			p = path.split '#'
			p[1] = "viewmodel" unless p[1]?
			throw new Error "Invalid router path #{path}" unless p[0]? and p[1]?
			return {
				module: p[0]
				viewmodel: p[1]
				method: p[2]
			}