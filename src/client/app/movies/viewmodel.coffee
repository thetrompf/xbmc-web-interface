define [
	"base/viewmodel"
	"text!app/movies/templates/movies.html"
	"xbmc/api/videolibrary"
	"xbmc/api/util"
	"vendor/nanoscroller/jquery.nanoscroller"
], (ViewModel, template, VideoLibrary, Util) ->
	class MoviesViewModel extends ViewModel

		ENTER = 13
		ESC   = 27
		PGUP  = 33
		PGDN  = 34
		END   = 35
		HOME  = 36
		LEFT  = 37
		UP    = 38
		RIGHT = 39
		DOWN  = 40

		SCROLLPAGE = 10

		bindingContext: "#main-container"
		template      : template
		template      = null
		self          = null
		videoLibrary  = null

		properties: () ->
			movies    : @observable []
			selected  : @observable null
			movieid   : @observable ""
			title     : @observable ""
			year      : @observable ""
			thumbnail : @observable ""
			plot      : @observable ""
			rating    : @observable ""

		afterInitialize: (opts) ->
			super
			self = @
			@videoLibrary = new VideoLibrary opts.client
			@videoLibrary.GetMovies
				params:
					properties: [
						"title"
						"rating"
					]
				callback:
					success: (msg) ->
						return if do @disposed
						@_.map msg.movies, (e) =>
							e.selected = @observable false
							e.rating = e.rating.toFixed 2
							return e
						@movies msg.movies
						@initEventHandlers()
					error: (err) -> debugger
				context: @

		initEventHandlers: () ->
			@$(document).on "keydown.movies", (e) =>
				if @_.contains [UP, DOWN, PGUP, PGDN], e.keyCode
					do e.preventDefault
					do e.stopPropagation
				switch e.keyCode
					when UP
						do @scrollUp
						return false
					when DOWN
						do @scrollDown
						return false
					when PGUP
						@scrollUp SCROLLPAGE
						return false
					when PGDN
						@scrollDown SCROLLPAGE
						return false

			@$(document).on "keyup.movies", (e) =>
				if @_.contains [HOME, END, ENTER, ESC], e.keyCode
					do e.preventDefault
					do e.stopPropagation
				switch e.keyCode
					when HOME
						@scrollUp -1
						return false
					when END
						@scrollDown -1
						return false
					when ENTER
						do @play
						return false

			@$movieContainer = @$el.find(".nano").nanoScroller
				contentClass: "nano-content"
				alwaysVisible: true
				preventPageScrolling: true

		scrollUp: (interval = 1) ->
			m = do @movies
			s = do @selected
			if interval is -1 # HOME
				movie = @_.first m
			else if not s? or (i = @_.indexOf m, s) is 0
				movie = @_.last m
				@$movieContainer.nanoScroller
					scroll: 'bottom'
			else
				movie = if not ((i = i - interval) < 0) then m[i] else @_.first m
			@showDetails movie

		scrollDown: (interval = 1) ->
			m = do @movies
			s = do @selected
			if interval is -1 #END
				movie = @_.last m
			else if not s? or (i = @_.indexOf m, s) is m.length - 1
				movie = @_.first m
				@$movieContainer.nanoScroller
					scroll: 'top'
			else
				movie = if not ((i = i + interval) > m.length - 1) then m[i] else @_.last m
			@showDetails movie

		selectMovie: () ->
			self.showDetails @

		showDetails: (movie) ->
			self.selected()?.selected false
			movie.selected true
			do @ensureScrollPosition
			self.fetchMovieDetails movie.movieid
			self.selected movie

		ensureScrollPosition: () ->
			$list = @$el.find(".movie-list")
			$active = @$el.find(".movie-list .active")
			if $list.scrollTop() + $active.position().top + $active.height() > $list.scrollTop() + $list.height()
				@$movieContainer.nanoScroller
					scrollTop: $active.position().top + $list.scrollTop() - $list.height() + ($active.height() * 1.5)
			# weird bug, aparently this check is necessary, when going from position 1 to 0 :S
			else if $list.scrollTop() + $active.position().top is 0
				@$movieContainer.nanoScroller
					scroll: 'top'
			else if $list.scrollTop() + $active.position().top < $list.scrollTop()
				@$movieContainer.nanoScroller
					scrollTop: $active.position().top + $list.scrollTop()


		fetchMovieDetails: (movieid) ->
			@videoLibrary.GetMovieDetails
				params:
					movieid: movieid
					properties: [
						"title"
						"year"
						"plot"
						"rating"
						"country"
						"director"
						"thumbnail"
					]
				callback: (data) ->
					return if do @disposed
					@movieid   data.moviedetails.movieid
					@title     data.moviedetails.title
					@year      data.moviedetails.year
					@thumbnail Util.parseImageResource data.moviedetails.thumbnail, @options.config, "w185"
					@plot      data.moviedetails.plot
					@rating    data.moviedetails.rating.toFixed 2
				context: @

		dispose: () ->
			@$(document).off ".movies"
			super
