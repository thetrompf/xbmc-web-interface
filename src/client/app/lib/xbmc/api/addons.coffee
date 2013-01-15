define [
	"underscore"
	"xbmc/base/api"
], (_, APIBase) ->
	###
	# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Addons
	###
	class Addons extends APIBase

		###
		# Executes the given addon with the given parameters (if possible).
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Addons.ExecuteAddon
		#
		# @var string addonid The addon id.
		# @var [ mixed params = null ] The parameters passed to the addon. optional
		# @var [ Boolean wait = false ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		ExecuteAddon: (options) ->
			method = "#{@_API}.ExecuteAddon"
			return @
			
		###
		# Gets the details of a specific addon.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Addons.GetAddonDetails
		#
		# @var string addonid The addon id.
		# @var [ Addon.Fields properties ] The properties you want in the result.
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { List.LimitsReturned limits, Addon.Details addon }
		# @return APIBase
		###
		GetAddonDetails: (options) ->
			method = "#{@_API}.GetAddonDetails"
			return @

		###
		# Gets all available addons.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Addons.GetAddons
		#
		# @var [ Addon.Types type = "unknown" ]
		# @var [ Addon.Content content = "unknown" ]
		# @var [ mixed enabled = "all" ]
		# @var [ Addon.Fields propties ]
		# @var [ List.Limits limits ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { List.LimitsReturned limits, [ Addon.Details addons ] }
		# @return APIBase
		###
		GetAddons: (options) ->
			method = "#{@_API}.GetAddons"
			return @
		
		###
		# Enables/Disables a specific addon.
		# @permission ManageAddon
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#Addons.SetAddonEnabled
		#
		# @var string addonid The addon id to disable.
		# @var Global.Toggle enabled
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###	
		SetAddonEnabled: (options) ->
			method = "#{@_API}.SetAddonEnabled"
			return @