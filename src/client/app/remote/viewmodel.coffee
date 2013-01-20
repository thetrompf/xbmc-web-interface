define [
	"base/viewmodel"
	"xbmc/clients/wsclient"
	"xbmc/api/input"
	"text!app/remote/templates/remote.html"
], (ViewModel, WSClient, Input, template) ->
	class RemoteViewModel extends ViewModel

		bindingContext: "#remote-container"
		$el: "#remote-container"
		template: template
		template = null

		client: null
		input: null

		properties: (options) ->
			url: options.url

		initialize: (options) ->
			@client = WSClient.get()
			@input = new Input @client

		afterInitialize: (options) ->