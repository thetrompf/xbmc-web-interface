define [
	"xbmc/base/api"
], (APIBase) ->
	###
	# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#XBMC
	###
	class XBMC extends APIBase

		###
		# Retrieve info booleans about XBMC and the system.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#XBMC.GetInfoBooleans
		#
		# @var array[1..X] booleans
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback Object
		# @return APIBase
		###
		GetInfoBooleans: (options) ->
			method = "#{@_API}.GetInfoBooleans"
			return @

		###
		# Retrieve info labels about XBMC and the system.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#XBMC.GetInfoLabels
		#
		# @var array[1..X] labels
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback object
		# @return APIBase
		###
		GetInfoLabels: (options) ->
			method = "#{@_API}.GetInfoLabels"
			return @
