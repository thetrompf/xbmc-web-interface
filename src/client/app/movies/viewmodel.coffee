define [
	"base/viewmodel"
	"text!app/movies/templates/movies.html"
	"app/lib/xbmc/clients/wsclient"
], (ViewModel, template, WSClient, Addon) ->
	class MoviesViewModel extends ViewModel

		bindingContext: "#main-container"
		wrapTemplate: true
		template: template
		template = null

		properties: (options) ->
			options.searchPlaceholder "Search movies..."
			title: @observable "Movies"

		subscriptions: (options) ->
			searchDelayed: @subscribe(options.searchDelayed, (newValue) ->
				if newValue.length > 3
					console.log "Search movies: #{newValue}"
			)

		initialize: (options) ->
			client = new WSClient.get()
			client.send
				method: "VideoLibrary.GetMovies"
				params:
					limits:
						end: 20
						start: 0
			,
				success: (msg) ->
					debugger
				error: (msg) ->
					debugger
			, @
