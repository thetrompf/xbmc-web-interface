define [
	"xbmc/base/api"
], (APIBase) ->
	###
	# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#GUI
	###
	class GUI extends APIBase

		###
		# Activates the given window.
		# @permission ControlGUI
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#GUI.ActivateWindow
		#
		# @var GUI.Window window
		# @var [ array[1..X] parameters ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		ActivateWindow: (options) ->
			method = "#{@_API}.ActivateWindow"
			return @
			
		###
		# Retrieves the values of the given properties.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#GUI.GetProperties
		#
		# @var GUI.Property.Name[] properties
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback GUI.Property.Value
		# @return APIBase
		###
		GetProperties: (options) ->
			method = "#{@_API}.GetProperties"
			return @
			
		###
		# Toggle fullscreen/GUI.
		# @permission ControlGUI
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#GUI.SetFullscreen
		#
		# @var Global.Toggle fullscreen
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback boolean
		# @return APIBase
		###
		SetFullscreen: (options) ->
			method = "#{@_API}.SetFullscreen"
			return @
			
		###
		# Shows a GUI notification.
		# @permission ControlGUI
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#GUI.ShowNotification
		#
		# @var string title
		# @var string message
		# @var [ mixed image = "" ]
		# @var [ integer displaytime = 5000 ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		ShowNotification: (options) ->
			method = "#{@_API}.ShowNotification"
			return @
			