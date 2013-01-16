define [
	"xbmc/base/api"
], (APIBase) ->
	###
	# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Player
	###
	class Player extends APIBase

		###
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Player_3
		###
		events: [
			"OnPause"
			"OnPlay"
			"OnPropertyChanged"
			"OnSeek"
			"OnSpeedChanged"
			"OnStop"
		]

		###
		# Returns all active players.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Player.GetActivePlayers
		#
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback array
		# @return APIBase
		###
		GetActivePlayers: (options) ->
			method = "#{@_API}.GetActivePlayers"
			@client.send
				method: method
			, options.callback, options.context
			return @

		###
		# Retrieves the currently played item.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Player.GetItem
		#
		# @var Player.Id playerid
		# @var [ List.Fields.All properties ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { List.Item.All item }
		# @return APIBase
		###
		GetItem: (options) ->
			method = "#{@_API}.GetItem"
			return @

		###
		# Retrieves the values of the given properties.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Player.GetProperties
		#
		# @var Player.Id playerid
		# @var Player.Property.Name[] properties
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback Player.Property.Value
		# @return APIBase
		###
		GetProperties: (options) ->
			method = "#{@_API}.GetProperties"
			@client.send
				method: method
				params:
					playerid: options.playerid
					properties: options.properties
			, options.callback, options.context
			return @

		###
		# Go to previous/next/specific item in the playlist.
		# @permission ControlPlayback
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Player.GoTo
		#
		# @var Player.Id playerid
		# @var mixed to
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		GoTo: (options) ->
			method = "#{@_API}.GoTo"
			return @

		###
		# If picture is zoomed move viewport left/right/up/down otherwise skip previous/next.
		# @permission ControlPlayback
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Player.Move
		#
		# @var Player.Id playerid
		# @var string direction
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Move: (options) ->
			method = "#{@_API}.Move"
			return @

		###
		# Start playback of either the playlist with the given ID, a slideshow with the pictures from the given directory or a single file or an item from the database.
		# @permission ControlPlayback
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Player.Open
		#
		# @var [ mixed item ]
		# @var [ object options ]
		#          [ Optional.Boolean shuffled = null ]
		#          [ mixed repeat = null ]
		#          [ mixed resume = False ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Open: (options) ->
			method = "#{@_API}.Open"
			return @

		###
		# Pauses or unpause playback and returns the new state.
		# @permission ControlPlayback
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Player.PlayPause
		#
		# @var Player.Id playerid
		# @var [ Global.Toggle play = "toggle" ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback Player.Speed
		# @return APIBase
		###
		PlayPause: (options) ->
			method = "#{@_API}.PlayPause"
			playerid = if options.playerid? then options.playerid else 1
			@client.send
				method: method
				params:
					playerid: playerid
			, options.callback, options.context
			return @

		###
		# Rotates current picture.
		# @permission ControlPlayback
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Player.Rotate
		#
		# @var Player.Id playerid
		# @var [ string value = "clockwise" ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Rotate: (options) ->
			method = "#{@_API}.Rotate"
			return @

		###
		# Seek through the playing item.
		# @permission ControlPlayback
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Player.Seek
		#
		# @var Player.Id playerid
		# @var mixed value
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { [ Player.Position.Percentage percentage = 0 ], [ Global.Time time ], [ Global.Time totaltime ] }
		# @return APIBase
		###
		Seek: (options) ->
			method = "#{@_API}.Seek"
			return @

		###
		# Set the audio stream played by the player.
		# @permission ControlPlayback
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Player.SetAudioStream
		#
		# @var Player.Id playerid
		# @var mixed stream
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		SetAudioStream: (options) ->
			method = "#{@_API}.SetAudioStream"
			return @

		###
		# Turn partymode on or off.
		# @permission ControlPlayback
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Player.SetPartymode
		#
		# @var Player.Id playerid
		# @var Global.Toggle partymode
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		SetPartymode: (options) ->
			method = "#{@_API}.SetPartymode"
			return @

		###
		# Set the repeat mode of the player.
		# @permission ControlPlayback
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Player.SetRepeat
		#
		# @var Player.Id playerid
		# @var mixed repeat
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		SetRepeat: (options) ->
			method = "#{@_API}.SetRepeat"
			return @

		###
		# Shuffle/Unshuffle items in the player.
		# @permission ControlPlayback
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Player.SetShuffle
		#
		# @var Player.Id playerid
		# @var Global.Toggle shuffle
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		SetShuffle: (options) ->
			method = "#{@_API}.SetShuffle"
			return @

		###
		# Set the speed of the current playback.
		# @permission ControlPlayback
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Player.SetSubtitle
		#
		# @var Player.Id playerid
		# @var mixed speed
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback Player.Speed
		# @return APIBase
		###
		SetSpeed: (options) ->
			method = "#{@_API}.SetSpeed"
			return @

		###
		# Set the subtitle displayed by the player.
		# @permission ControlPlayback
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Player.Stop
		#
		# @var Player.Id playerid
		# @var mixed subtitle
		# @var [ boolean enable = False ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		SetSubtitle: (options) ->
			method = "#{@_API}.SetSubtitle"
			return @

		###
		# Stops playback.
		# @permission ControlPlayback
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Player.Zoom
		#
		# @var Player.Id playerid
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Stop: (options) ->
			method = "#{@_API}.Stop"
			@client.send
				method: method
				params:
					playerid: options.playerid
			, options.callback, options.context
			return @

		###
		# Zoom current picture.
		# @permission ControlPlayback
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Player.SetSpeed
		#
		# @var Player.Id playerid
		# @var mixed zoom
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Zoom: (options) ->
			method = "#{@_API}.Zoom"
			return @
