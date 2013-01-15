define [
	"xbmc/base/api"
], (APIBase) ->
	###
	# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Playlist
	###
	class Playlist extends APIBase

		###
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Playlist_3
		###
		events: [
			"OnAdd"
			"OnClear"
			"OnRemove"
		]

		###
		# Add item(s) to playlist.
		# @permission ControlPlayback
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Playlist.Add
		#
		# @var Playlist.Id playlistid
		# @var Playlist.Item item
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Add: (options) ->
			method = "#{@_API}.Add"
			return @

		###
		# Clear playlist.
		# @permission ControlPlayback
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Playlist.Clear
		#
		# @var Playlist.Id playlistid
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Clear: (options) ->
			method = "#{@_API}.Clear"
			return @

		###
		# Get all items from playlist.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Playlist.GetItems
		#
		# @var Playlist.Id playlistid
		# @var [ List.Fields.All properties ]
		# @var [ List.Limits limits ]
		# @var [ List.Sort sort ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { List.LimitsReturned limits, List.Item.All[] items }
		# @return APIBase
		###
		GetItems: (options) ->
			method = "#{@_API}.GetItems"
			return @

		###
		# Returns all existing playlists.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Playlist.GetPlaylists
		#
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback array
		# @return APIBase
		###
		GetPlaylists: (options) ->
			method = "#{@_API}.GetPlaylists"
			return @

		###
		# Retrieves the values of the given properties.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Playlist.GetProperties
		#
		# @var Playlist.Id playlistid
		# @var Playlist.Property.Name[] properties
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback Playlist.Property.Value
		# @return APIBase
		###
		GetProperties: (options) ->
			method = "#{@_API}.GetProperties"
			return @

		###
		# Insert item(s) into playlist. Does not work for picture playlists (aka slideshows).
		# @permission ControlPlayback
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Playlist.Insert
		#
		# @var Playlist.Id playlistid
		# @var Playlist.Position position
		# @var Playlist.Item item
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Insert: (options) ->
			method = "#{@_API}.Insert"
			return @

		###
		# Remove item from playlist. Does not work for picture playlists (aka slideshows).
		# @permission ControlPlayback
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Playlist.Remove
		#
		# @var Playlist.Id playlistid
		# @var Playlist.Position position
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Remove: (options) ->
			method = "#{@_API}.Remove"
			return @

		###
		# Swap items in the playlist. Does not work for picture playlists (aka slideshows).
		# @permission ControlPlayback
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Playlist.Swap
		#
		# @var Playlist.Id playlistid
		# @var Playlist.Position position1
		# @var Playlist.Position position2
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Swap: (options) ->
			method = "#{@_API}.Swap"
			return @
