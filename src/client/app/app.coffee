define [
	"underscore"
	"base/viewmodel"
	"base/router"
	"app/routes"
	"app/config"
	"xbmc/clients/wsclient"
	"app/player/viewmodel"
	"date/format"
], (_, ViewModelBase, Router, routes, config, WSClient, PlayerViewModel) ->

	class Global extends ViewModelBase
		bindingContext: "#global-system"
		template: ""
		dateInterval = null

		properties: () ->
			date: @observable new Date
			weather: @observable "8&deg;C"

		computedProperties: () ->
			formatedDate: @computed () =>
				f = @date().format config.i18n.longDateFormat, config.i18n.utc
				return f

		afterInitialize: () ->
			dateInterval = setInterval () =>
				@date new Date
			, 10000

	class Application

		_(@.prototype).extend Router.prototype

		constructor: (args) ->
			@client = @client = WSClient.get config.jsonrpc.host, config.jsonrpc.port
			options =
				url: @url
				client: @client
				global: @global
				config: config

			@global = new Global options
			options.global = @global

			@player = new PlayerViewModel options

			@initRouter routes, options
			options.router = @router
