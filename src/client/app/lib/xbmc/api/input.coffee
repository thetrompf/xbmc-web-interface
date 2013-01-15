define [
	"xbmc/base/api"
], (APIBase) ->
	###
	# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Input
	###
	class Input extends APIBase

		###
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Input_3
		###
		events: [
			"OnInputFinished"
			"OnInputRequested"
		]

		###
		# Goes back in GUI.
		# @permission Navigate
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Input.Back
		#
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Back: (options) ->
			method = "#{@_API}.Back"
			return @
			
		###
		# Shows the context menu.
		# @permission Navigate
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Input.ContextMenu
		#
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		ContextMenu: (options) ->
			method = "#{@_API}.ContextMenu"
			return @
			
		###
		# Navigate down in GUI.
		# @permission Navigate
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Input.Down
		#
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Down: (options) ->
			method = "#{@_API}.Down"
			return @
			
		###
		# Execute a specific action.
		# @permission Navigate
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Input.ExecuteAction
		#
		# @var Input.Action action
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		ExecuteAction: (options) ->
			method = "#{@_API}.ExecuteAction"
			return @
			
		###
		# Goes to home window in GUI.
		# @permission Navigate
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Input.Home
		#
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Home: (options) ->
			method = "#{@_API}.Home"
			return @
			
		###
		# Shows the information dialog.
		# @permission Navigate
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Input.Info
		#
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Info: (options) ->
			method = "#{@_API}.Info"
			return @
			
		###
		# Navigate left in GUI.
		# @permission Navigate
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Input.Left
		#
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Left: (options) ->
			method = "#{@_API}.Left"
			return @
			
		###
		# Navigate right in GUI.
		# @permission Navigate
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Input.Right
		#
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Right: (options) ->
			method = "#{@_API}.Right"
			return @
			
		###
		# Select current item in GUI.
		# @permission Navigate
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Input.Select
		#
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Select: (options) ->
			method = "#{@_API}.Select"
			return @
			
		###
		# Send a generic (unicode) text.
		# @permission Navigate
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Input.SendText
		#
		# @var string text
		# @var [ boolean done = True ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		SendText: (options) ->
			method = "#{@_API}.SendText"
			return @
			
		###
		# Show codec information of the playing item.
		# @permission Navigate
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Input.ShowCodec
		#
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		ShowCodec: (options) ->
			method = "#{@_API}.ShowCodec"
			return @
			
		###
		# Show the on-screen display for the current player.
		# @permission Navigate
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Input.ShowOSD
		#
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		ShowOSD: (options) ->
			method = "#{@_API}.ShowOSD"
			return @
			
		###
		# Navigate up in GUI.
		# @permission Navigate
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Input.Up
		#
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Up: (options) ->
			method = "#{@_API}.Up"
			return @
			