define [
	"xbmc/base/api"
], (APIBase) ->
	###
	# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Application
	###
	class Application extends APIBase

		###
		#	@see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Application_3
		###
		events: [
			"OnVolumeChanged"
		]

		###
		# Retrieves the values of the given properties.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Application.GetProperties
		#
		# @var Application.Property.Name[] properties
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback Application.Property.Value
		# @return APIBase
		###
		GetProperties: (options) ->
			method = "#{@_API}.GetProperties"
			return @
			
		###
		# Quit application.
		# @permission ControlPower
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Application.Quit
		#
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback String
		# @return APIBase
		###
		Quit: (options) ->
			method = "#{@_API}.Quit"
			@client.send
				method: method
			, options.callback, options.context
			return @
		
		###
		# Toggle mute/unmute.
		# @permission ControlPlayback
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Application.SetMute
		#
		# @var Global.Toggle mute
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback Boolean
		# @return APIBase
		###
		SetMute: (options) ->
			method = "#{@_API}.SetMute"
			return @
		
		###
		# Set the current volume.
		# @permission ControlPlayback
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Application.SetVolume
		#
		# @var mixed volume
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback Integer
		# @return APIBase
		###
		SetVolume: (options) ->
			method = "#{@_API}.SetVolume"
			return @
			