define [
	"xbmc/base/api"
], (APIBase) ->
	###
	# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#AudioLibrary
	###
	class AudioLibrary extends APIBase		
		
		###
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#AudioLibrary_2
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
		# Cleans the audio library from non-existent items.
		# @permission RemoveData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#AudioLibrary.Clean
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
		# Exports all items from the audio library.
		# @permission WriteFile
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#AudioLibrary.Export
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
		# Retrieve details about a specific album.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#AudioLibrary.GetAlbumDetails
		#
		# @var Library.Id albumid
		# @var [ Audio.Fields.Album properties ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { [ Audio.Details.Album albumdetails ] }
		# @return APIBase
		###
		GetAlbumDetails: (options) ->
			method = "#{@_API}.GetAlbumDetails"
			return @
		
		###
		# Retrieve all albums from specified artist or genre.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#AudioLibrary.GetAlbums
		#
		# @var [ Audio.Fields.Album properties ]
		# @var [ List.Limits limits ]
		# @var [ List.Sort sort ]
		# @var [ mixed filter ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { [ Audio.Details.Album[] albums ], List.LimitsReturned limits }
		# @return APIBase
		###
		GetAlbums: (options) ->
			method = "#{@_API}.GetAlbums"
			return @
		
		###
		# Retrieve details about a specific artist.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#AudioLibrary.GetArtistDetails
		#
		# @var Library.Id artistid
		# @var [ Audio.Fields.Artist properties ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { [ Audio.Details.Artist artistdetails ] }
		# @return APIBase
		###
		GetArtistDetails: (options) ->
			method = "#{@_API}.GetArtistDetails"
			return @
		
		###
		# Retrieve details about a specific artist.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#AudioLibrary.GetArtists
		#
		# @var [ Optional.Boolean albumartistsonly = null ]
		# @var [ Audio.Fields.Artist properties ]
		# @var [ List.Limits limits ]
		# @var [ List.Sort sort ]
		# @var [ mixed filter ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { List.LimitsReturned limits, [ Audio.Details.Artist[] artists ] }
		# @return APIBase
		###
		GetArtists: (options) ->
			method = "#{@_API}.GetArtists"
			return @

		###
		# Retrieve all genres.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#AudioLibrary.GetGenres
		#
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
		# Retrieve recently added albums.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#AudioLibrary.GetRecentlyAddedAlbums
		#
		# @var [ Audio.Fields.Album properties ]
		# @var [ List.Limits limits ]
		# @var [ List.Sort sort ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { [ Audio.Details.Album[] albums ], List.LimitsReturned limits }
		# @return APIBase
		###
		GetRecentlyAddedAlbums: (options) ->
			method = "#{@_API}.GetRecentlyAddedAlbums"
			return @
			
		###
		# Retrieve recently added songs.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#AudioLibrary.GetRecentlyAddedSongs
		#
		# @var [ List.Amount albumlimit = -1 ]
		# @var [ Audio.Fields.Song properties ]
		# @var [ List.Limits limits ]
		# @var [ List.Sort sort ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { List.LimitsReturned limits, [ Audio.Details.Song[] songs ] }
		# @return APIBase
		###
		GetRecentlyAddedSongs: (options) ->
			method = "#{@_API}.GetRecentlyAddedSongs"
			return @
			
		###
		# Retrieve recently played albums.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#AudioLibrary.GetRecentlyPlayedAlbums
		#
		# @var [ Audio.Fields.Album properties ]
		# @var [ List.Limits limits ]
		# @var [ List.Sort sort ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { [ Audio.Details.Album[] albums ], List.LimitsReturned limits }
		# @return APIBase
		###
		GetRecentlyPlayedAlbums: (options) ->
			method = "#{@_API}.GetRecentlyPlayedAlbums"
			return @
			
		###
		# Retrieve recently played songs.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#AudioLibrary.GetRecentlyPlayedSongs
		#
		# @var [ Audio.Fields.Song properties ]
		# @var [ List.Limits limits ]
		# @var [ List.Sort sort ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { List.LimitsReturned limits, [ Audio.Details.Song[] songs ] }
		# @return APIBase
		###
		GetRecentlyPlayedSongs: (options) ->
			method = "#{@_API}.GetRecentlyPlayedSongs"
			return @
			
		###
		# Retrieve details about a specific song.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#AudioLibrary.GetSongDetails
		#
		# @var Library.Id songid
		# @var [ Audio.Fields.Song properties ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { [ Audio.Details.Song songdetails ] }
		# @return APIBase
		###
		GetSongDetails: (options) ->
			method = "#{@_API}.GetSongDetails"
			return @
			
		###
		# Retrieve all songs from specified album, artist or genre.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#AudioLibrary.GetSongs
		#
		# @var [ Audio.Fields.Song properties ]
		# @var [ List.Limits limits ]
		# @var [ List.Sort sort ]
		# @var [ mixed filter ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { List.LimitsReturned limits, [ Audio.Details.Song[] songs ] }
		# @return APIBase
		###
		GetSongs: (options) ->
			method = "#{@_API}.GetSongs"
			return @
			
		###
		# Scans the audio sources for new library items.
		# @permission UpdateData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#AudioLibrary.Scan
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
		# Update the given album with the given details.
		# @permission UpdateData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#AudioLibrary.SetAlbumDetails
		#
		# @var Library.Id albumid
		# @var [ Optional.String title = null ]
		# @var [ mixed artist = null ]
		# @var [ Optional.String description = null ]
		# @var [ mixed genre = null ]
		# @var [ mixed theme = null ]
		# @var [ mixed mood = null ]
		# @var [ mixed style = null ]
		# @var [ Optional.String type = null ]
		# @var [ Optional.String albumlabel = null ]
		# @var [ Optional.Integer rating = null ]
		# @var [ Optional.Integer year = null ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		SetAlbumDetails: (options) ->
			method = "#{@_API}.SetAlbumDetails"
			return @
			
		###
		# Update the given artist with the given details.
		# @permission UpdateData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#AudioLibrary.SetArtistDetails
		#
		# @var Library.Id artistid
		# @var [ Optional.String artist = null ]
		# @var [ mixed instrument = null ]
		# @var [ mixed style = null ]
		# @var [ mixed mood = null ]
		# @var [ Optional.String born = null ]
		# @var [ Optional.String formed = null ]
		# @var [ Optional.String description = null ]
		# @var [ mixed genre = null ]
		# @var [ Optional.String died = null ]
		# @var [ Optional.String disbanded = null ]
		# @var [ mixed yearsactive = null ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		SetArtistDetails: (options) ->
			method = "#{@_API}.SetArtistDetails"
			return @
			
		###
		# Update the given song with the given details.
		# @permission UpdateData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#AudioLibrary.SetSongDetails
		#
		# @var Library.Id songid
		# @var [ Optional.String title = null ]
		# @var [ mixed artist = null ]
		# @var [ mixed albumartist = null ]
		# @var [ mixed genre = null ]
		# @var [ Optional.Integer year = null ]
		# @var [ Optional.Integer rating = null ]
		# @var [ Optional.String album = null ]
		# @var [ Optional.Integer track = null ]
		# @var [ Optional.Integer disc = null ]
		# @var [ Optional.Integer duration = null ]
		# @var [ Optional.String comment = null ]
		# @var [ Optional.String musicbrainztrackid = null ]
		# @var [ Optional.String musicbrainzartistid = null ]
		# @var [ Optional.String musicbrainzalbumid = null ]
		# @var [ Optional.String musicbrainzalbumartistid = null ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		SetSongDetails: (options) ->
			method = "#{@_API}.SetSongDetails"
			return @
			