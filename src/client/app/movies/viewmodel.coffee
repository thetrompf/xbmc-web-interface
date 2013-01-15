define [
	"base/viewmodel"
	"text!app/movies/templates/movies.html"
	"xbmc/clients/wsclient"
	"xbmc/api/videolibrary"
], (ViewModel, template, WSClient, VideoLibrary) ->
	class MoviesViewModel extends ViewModel

		bindingContext: "#main-container"
		wrapTemplate: true
		template: template
		template = null
		client: null
		videolibrary: null

		moreMovies: () ->
			if @moviesLeft()
				@videolibrary.getMovieList
					callback:
						success: (msg) ->
							msg.limits.start = msg.limits.end
							msg.limits.end += @moviesPerPage unless msg.limits.end is msg.limits.total
							@movieLimits msg.limits
							@movies @_.union @movies(), msg.movies
						error: (msg) ->
							debugger
					limits: @movieLimits()
					context: @

		resetMovies: () ->
			@movies []
			@movieLimits
				start: 0
				end: @moviesPerPage
				total: -1

		properties: (options) ->
			options.searchPlaceholder "Search movies..."
			title: @observable "Movies"
			movies: @observable []
			movieLimits: @observable
				start: 0
				end: 100
				total: -1
			moviesPerPage: 100

		computedProperties: (options) ->
			moviesLeft: @computed () ->
				return yes if @movieLimits().total < 0
				return yes unless @movieLimits().end is @movieLimits().total
				return no
			resetDisable: @computed () -> @movies().length < 1

		subscriptions: (options) ->
			searchDelayed: @subscribe(options.searchDelayed, (newValue) ->
				if newValue.length > 3
					console.log "Search movies: #{newValue}"
			)

		initialize: (options) ->
			@client = new WSClient.get()
			@videolibrary = new VideoLibrary @client
			@videolibrary.bind "OnScanFinished.movies", (msg) ->
				@videolibrary.unbind "movies"
			, @

		dispose: () ->
			super
			@videolibrary.dispose()
