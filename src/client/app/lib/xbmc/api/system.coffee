define [
	"xbmc/base/api"
], (APIBase) ->
	###
	# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#System
	###
	class System extends APIBase

		###
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#System_3
		###
		events: [
			"OnLowBattery"
			"OnQuit"
			"OnRestart"
			"OnSleep"
			"OnWake"
		]

		###
		# Ejects or closes the optical disc drive (if available).
		# @permission ControlSystem
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#System.EjectOpticalDrive
		#
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		EjectOpticalDrive: (options) ->
			method = "#{@_API}.EjectOpticalDrive"
			return @

		###
		# Retrieves the values of the given properties.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#System.GetProperties
		#
		# @var System.Property.Name[] properties
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback System.Property.Value
		# @return APIBase
		###
		GetProperties: (options) ->
			method = "#{@_API}.GetProperties"
			return @

		###
		# Puts the system running XBMC into hibernate mode.
		# @permission ControlPower
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#System.Hibernate
		#
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Hibernate: (options) ->
			method = "#{@_API}.Hibernate"
			return @

		###
		# Reboots the system running XBMC.
		# @permission ControlPower
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#System.Reboot
		#
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Reboot: (options) ->
			method = "#{@_API}.Reboot"
			return @

		###
		# Shuts the system running XBMC down.
		# @permission ControlPower
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#System.Shutdown
		#
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Shutdown: (options) ->
			method = "#{@_API}.Shutdown"
			return @

		###
		# Suspends the system running XBMC.
		# @permission ControlPower
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#System.Suspend
		#
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Suspend: (options) ->
			method = "#{@_API}.Suspend"
			return @
