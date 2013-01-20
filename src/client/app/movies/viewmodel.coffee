define [
	"base/viewmodel"
	"text!app/movies/templates/movies.html"
	"xbmc/clients/wsclient"
	"xbmc/api/player"
	"xbmc/api/videolibrary"
], (ViewModel, template, WSClient, Player, VideoLibrary) ->
	class MoviesViewModel extends ViewModel

		bindingContext: "#main-container"
		wrapTemplate: true
		template: template
		template = null
		client: null
		videolibrary: null
		self = null

		moreMovies: () ->
			if @moviesLeft()
				@videolibrary.getMovieList
					callback:
						success: (msg) ->
							msg.limits.start = msg.limits.end
							msg.limits.end += @moviesPerPage unless msg.limits.end is msg.limits.total
							@movieLimits msg.limits
							@movies @_.union @movies(), msg.movies if msg.movies
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

		chooseMovie: () ->
			self.player.Open
				callback:
					success: (msg) ->
					error: (msg) => console.error "Failed to play movieid: #{@movieid}", msg
				item:
					movieid: @movieid
				options:
					resume: true

		properties: (options) ->
			options.searchPlaceholder "Search movies..."
			title: @observable "Movies"
			movies: @observable []
			movieLimits: @observable
				start: 0
				end: 100
				total: -1
			moviesPerPage: 100
			player: options.player

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
			self = @
			@client = new WSClient.get "localhost", 9090
			@videolibrary = new VideoLibrary @client
			@player = new Player @client

		dispose: () ->
			super
			@videolibrary.dispose()
			@player.dispose()
