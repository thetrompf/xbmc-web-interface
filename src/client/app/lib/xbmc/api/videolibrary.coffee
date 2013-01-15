define [
	"xbmc/base/api"
], (APIBase) ->
	###
	# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary
	###
	class VideoLibrary extends APIBase
		
		###
		#	@see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary_2
		###		
		events: [
			"OnCleanFinished"
			"OnCleanStarted"
			"OnRemove"
			"OnScanFinished"
			"OnScanStarted"
			"OnUpdate"
		]

		###
		# Cleans the video library from non-existent items.
		# @permission RemoveData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary.Clean
		#
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Clean: (options) ->
			method = "#{@_API}.Clean"
			return @

		###
		# Exports all items from the video library.
		# @permission WriteFile
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary.Export
		#
		# @var [ mixed options ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Export: (options) ->
			method = "#{@_API}.Export"
			return @

		###
		# Retrieve details about a specific tv show episode.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary.GetEpisodeDetails
		#
		# @var Library.Id episodeid
		# @var [ Video.Fields.Episode properties ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { [ Video.Details.Episode episodedetails ] }
		# @return APIBase
		###
		GetEpisodeDetails: (options) ->
			method = "#{@_API}.GetEpisodeDetails"
			return @

		###
		# Retrieve all tv show episodes.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary.GetEpisodes
		#
		# @var[ Library.Id tvshowid = -1 ]
		# @var[ integer season = -1 ]
		# @var[ Video.Fields.Episode properties ]
		# @var[ List.Limits limits ]
		# @var[ List.Sort sort ]
		# @var[ mixed filter ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { [ Video.Details.Episode[] episodes ], List.LimitsReturned limits }
		# @return APIBase
		###
		GetEpisodes: (options) ->
			method = "#{@_API}.GetEpisodes"
			return @

		###
		# Retrieve all genres.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary.GetGenres
		#
		# @var string type
		# @var [ Library.Fields.Genre properties ]
		# @var [ List.Limits limits ]
		# @var [ List.Sort sort ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { Library.Details.Genre[] genres, List.LimitsReturned limits }
		# @return APIBase
		###
		GetGenres: (options) ->
			method = "#{@_API}.GetGenres"
			return @

		###
		# Retrieve details about a specific movie.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary.GetMovieDetails
		#
		# @var Library.Id movieid
		# @var [ Video.Fields.Movie properties ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { [ Video.Details.Movie moviedetails ] }
		# @return APIBase
		###
		GetMovieDetails: (options) ->
			method = "#{@_API}.GetMovieDetails"
			return @

		###
		# Retrieve details about a specific movie set.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary.GetMovieSetDetails
		#
		# @var Library.Id setid
		# @var [ Video.Fields.MovieSet properties ]
		# @var [ object movies ]
		#          [ List.Limits limits ]
		#          [ Video.Fields.Movie properties ]
		#          [ List.Sort sort ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { [ Video.Details.MovieSet.Extended setdetails ] }
		# @return APIBase
		###
		GetMovieSetDetails: (options) ->
			method = "#{@_API}.GetMovieSetDetails"
			return @

		###
		# Retrieve all movie sets.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary.GetMovieSets
		#
		# @var [ Video.Fields.MovieSet properties ]
		# @var [ List.Limits limits ]
		# @var [ List.Sort sort ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { List.LimitsReturned limits, [ Video.Details.MovieSet[] sets ] }
		# @return APIBase
		###
		GetMovieSets: (options) ->
			method = "#{@_API}.GetMovieSets"
			return @

		###
		# Retrieve all movies.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary.GetMovies
		#
		# @var [ Video.Fields.Movie properties ]
		# @var [ List.Limits limits ]
		# @var [ List.Sort sort ]
		# @var [ mixed filter ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { List.LimitsReturned limits, [ Video.Details.Movie[] movies ] }
		# @return APIBase
		###
		GetMovies: (options) ->
			method = "#{@_API}.GetMovies"
			return @

		###
		# Retrieve details about a specific music video.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary.GetMusicVideoDetails
		#
		# @var Library.Id musicvideoid
		# @var [ Video.Fields.MusicVideo properties ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { [ Video.Details.MusicVideo musicvideodetails ] }
		# @return APIBase
		###
		GetMusicVideoDetails: (options) ->
			method = "#{@_API}.GetMusicVideoDetails"
			return @

		###
		# Retrieve all music videos.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary.GetMusicVideos
		#
		# @var [ Video.Fields.MusicVideo properties ]
		# @var [ List.Limits limits ]
		# @var [ List.Sort sort ]
		# @var [ mixed filter ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { List.LimitsReturned limits, [ Video.Details.MusicVideo[] musicvideos ] }
		# @return APIBase
		###
		GetMusicVideos: (options) ->
			method = "#{@_API}.GetMusicVideos"
			return @

		###
		# Retrieve all recently added tv episodes.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary.GetRecentlyAddedEpisodes
		#
		# @var [ Video.Fields.Episode properties ]
		# @var [ List.Limits limits ]
		# @var [ List.Sort sort ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { [ Video.Details.Episode[] episodes ], List.LimitsReturned limits }
		# @return APIBase
		###
		GetRecentlyAddedEpisodes: (options) ->
			method = "#{@_API}.GetRecentlyAddedEpisodes"
			return @

		###
		# Retrieve all recently added movies.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary.GetRecentlyAddedMovies
		#
		# @var [ Video.Fields.Movie properties ]
		# @var [ List.Limits limits ]
		# @var [ List.Sort sort ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { List.LimitsReturned limits, [ Video.Details.Movie[] movies ] }
		# @return APIBase
		###
		GetRecentlyAddedMovies: (options) ->
			method = "#{@_API}.GetRecentlyAddedMovies"
			return @

		###
		# Retrieve all recently added music videos.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary.GetRecentlyAddedMusicVideos
		#
		# @var [ Video.Fields.MusicVideo properties ]
		# @var [ List.Limits limits ]
		# @var [ List.Sort sort ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { List.LimitsReturned limits, [ Video.Details.MusicVideo[] musicvideos ] }
		# @return APIBase
		###
		GetRecentlyAddedMusicVideos: (options) ->
			method = "#{@_API}.GetRecentlyAddedMusicVideos"
			return @

		###
		# Retrieve all tv seasons.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary.GetSeasons
		#
		# @var Library.Id tvshowid
		# @var [ Video.Fields.Season properties ]
		# @var [ List.Limits limits ]
		# @var [ List.Sort sort ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { List.LimitsReturned limits, [ Video.Details.Season[] seasons ] }
		# @return APIBase
		###
		GetSeasons: (options) ->
			method = "#{@_API}.GetSeasons"
			return @

		###
		# Retrieve details about a specific tv show.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary.GetTVShowDetails
		#
		# @var Library.Id tvshowid
		# @var [ Video.Fields.TVShow properties ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { [ Video.Details.TVShow tvshowdetails ] }
		# @return APIBase
		###
		GetTVShowDetails: (options) ->
			method = "#{@_API}.GetTVShowDetails"
			return @

		###
		# Retrieve all tv shows.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary.GetTVShows
		#
		# @var [ Video.Fields.TVShow properties ]
		# @var [ List.Limits limits ]
		# @var [ List.Sort sort ]
		# @var [ mixed filter ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { List.LimitsReturned limits, [ Video.Details.TVShow[] tvshows ] }
		# @return APIBase
		###
		GetTVShows: (options) ->
			method = "#{@_API}.GetTVShows"
			return @

		###
		# Removes the given episode from the library.
		# @permission RemoveData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary.RemoveEpisode
		#
		# @var Library.Id episodeid
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		RemoveEpisode: (options) ->
			method = "#{@_API}.RemoveEpisode"
			return @

		###
		# Removes the given movie from the library.
		# @permission RemoveData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary.RemoveMovie
		#
		# @var Library.Id movieid
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		RemoveMovie: (options) ->
			method = "#{@_API}.RemoveMovie"
			return @

		###
		# Removes the given music video from the library.
		# @permission RemoveData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary.RemoveMusicVideo
		#
		# @var Library.Id musicvideoid
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		RemoveMusicVideo: (options) ->
			method = "#{@_API}.RemoveMusicVideo"
			return @

		###
		# Removes the given tv show from the library.
		# @permission RemoveData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary.RemoveTVShow
		#
		# @var Library.Id tvshowid
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		RemoveTVShow: (options) ->
			method = "#{@_API}.RemoveTVShow"
			return @

		###
		# Scans the video sources for new library items.
		# @permission UpdateData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary.Scan
		#
		# @var [ string directory = "" ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Scan: (options) ->
			method = "#{@_API}.Scan"
			return @

		###
		# Update the given episode with the given details.
		# @permission UpdateData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary.SetEpisodeDetails
		#
		# @var Library.Id episodeid
		# @var [ Optional.String title = null ]
		# @var [ Optional.Integer playcount = null ]
		# @var [ Optional.Integer runtime = null ]
		# @var [ mixed director = null ]
		# @var [ Optional.String plot = null ]
		# @var [ Optional.Number rating = null ]
		# @var [ Optional.String votes = null ]
		# @var [ Optional.String lastplayed = null ]
		# @var [ mixed writer = null ]
		# @var [ Optional.String firstaired = null ]
		# @var [ Optional.String productioncode = null ]
		# @var [ Optional.Integer season = null ]
		# @var [ Optional.Integer episode = null ]
		# @var [ Optional.String originaltitle = null ]
		# @var [ Optional.String thumbnail = null ]
		# @var [ Optional.String fanart = null ]
		# @var [ mixed art = null ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		SetEpisodeDetails: (options) ->
			method = "#{@_API}.SetEpisodeDetails"
			return @

		###
		# Update the given movie with the given details.
		# @permission UpdateData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary.SetMovieDetails
		#
		# @var Library.Id movieid
		# @var [ Optional.String title = null ]
		# @var [ Optional.Integer playcount = null ]
		# @var [ Optional.Integer runtime = null ]
		# @var [ mixed director = null ]
		# @var [ mixed studio = null ]
		# @var [ Optional.Integer year = null ]
		# @var [ Optional.String plot = null ]
		# @var [ mixed genre = null ]
		# @var [ Optional.Number rating = null ]
		# @var [ Optional.String mpaa = null ]
		# @var [ Optional.String imdbnumber = null ]
		# @var [ Optional.String votes = null ]
		# @var [ Optional.String lastplayed = null ]
		# @var [ Optional.String originaltitle = null ]
		# @var [ Optional.String trailer = null ]
		# @var [ Optional.String tagline = null ]
		# @var [ Optional.String plotoutline = null ]
		# @var [ mixed writer = null ]
		# @var [ mixed country = null ]
		# @var [ Optional.Integer top250 = null ]
		# @var [ Optional.String sorttitle = null ]
		# @var [ Optional.String set = null ]
		# @var [ mixed showlink = null ]
		# @var [ Optional.String thumbnail = null ]
		# @var [ Optional.String fanart = null ]
		# @var [ mixed tag = null ]
		# @var [ mixed art = null ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		SetMovieDetails: (options) ->
			method = "#{@_API}.SetMovieDetails"
			return @

		###
		# Update the given music video with the given details.
		# @permission UpdateData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary.SetMusicVideoDetails
		#
		# @var Library.Id musicvideoid
		# @var [ Optional.String title = null ]
		# @var [ Optional.Integer playcount = null ]
		# @var [ Optional.Integer runtime = null ]
		# @var [ mixed director = null ]
		# @var [ mixed studio = null ]
		# @var [ Optional.Integer year = null ]
		# @var [ Optional.String plot = null ]
		# @var [ Optional.String album = null ]
		# @var [ mixed artist = null ]
		# @var [ mixed genre = null ]
		# @var [ Optional.Integer track = null ]
		# @var [ Optional.String lastplayed = null ]
		# @var [ Optional.String thumbnail = null ]
		# @var [ Optional.String fanart = null ]
		# @var [ mixed tag = null ]
		# @var [ mixed art = null ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		SetMusicVideoDetails: (options) ->
			method = "#{@_API}.SetMusicVideoDetails"
			return @

		###
		# Update the given tvshow with the given details.
		# @permission UpdateData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#VideoLibrary.SetTVShowDetails
		#
		# @var Library.Id tvshowid
		# @var [ Optional.String title = null ]
		# @var [ Optional.Integer playcount = null ]
		# @var [ mixed studio = null ]
		# @var [ Optional.String plot = null ]
		# @var [ mixed genre = null ]
		# @var [ Optional.Number rating = null ]
		# @var [ Optional.String mpaa = null ]
		# @var [ Optional.String imdbnumber = null ]
		# @var [ Optional.String premiered = null ]
		# @var [ Optional.String votes = null ]
		# @var [ Optional.String lastplayed = null ]
		# @var [ Optional.String originaltitle = null ]
		# @var [ Optional.String sorttitle = null ]
		# @var [ Optional.String episodeguide = null ]
		# @var [ Optional.String thumbnail = null ]
		# @var [ Optional.String fanart = null ]
		# @var [ mixed tag = null ]
		# @var [ mixed art = null ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		SetTVShowDetails: (options) ->
			method = "#{@_API}.SetTVShowDetails"
			return @

		getMovieList: (options) ->
			limits = ((l) ->
				return {
					start: l.start
					end: l.end
				}
			)(options.limits)
			@client.send
				method: "VideoLibrary.GetMovies"
				params:
					limits: limits
					properties: [ "title", "year", "sorttitle", "originaltitle" ]
			, options.callback, options.context
