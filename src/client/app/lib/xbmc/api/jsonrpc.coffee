define [
	"xbmc/base/api"
], (APIBase) ->
	###
	# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#JSONRPC
	###
	class JSONRPC extends APIBase

		###
		# Get client-specific configurations.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#JSONRPC.GetConfiguration
		#
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback Configuration
		# @return APIBase
		###
		GetConfiguration: (options) ->
			method = "#{@_API}.GetConfiguration"
			return @
			
		###
		# Enumerates all actions and descriptions.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#JSONRPC.Introspect
		#
		# @var [ boolean getdescriptions = True ]
		# @var [ boolean getmetadata = False ]
		# @var [ boolean filterbytransport = True ]
		# @var [ object filter ]
		#         [ boolean getreferences = True ]
		#         string id
		#         string type - enum: [ "method", "namespace", "type", "notification" ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback Object
		# @return APIBase
		###
		Introspect: (options) ->
			method = "#{@_API}.Introspect"
			return @
			
		###
		# Notify all other connected clients.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#JSONRPC.NotifyAll
		#
		# @var string sender
		# @var string message
		# @var [ any data = null ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback any
		# @return APIBase
		###
		NotifyAll: (options) ->
			method = "#{@_API}.NotifyAll"
			return @
			
		###
		# Retrieve the clients permissions.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#JSONRPC.Permission
		#
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { boolean readdata, boolean writefile, boolean controlpvr, boolean controlsystem, boolean removedata, boolean controlplayback, boolean navigate, boolean controlpower, boolean executeaddon, boolean manageaddon, boolean controlgui, boolean controlnotify, boolean updatedata }
		# @return APIBase
		###
		Permission: (options) ->
			method = "#{@_API}.Permission"
			return @
			
		###
		# Ping responder.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#JSONRPC.Ping
		#
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback string
		# @return APIBase
		###
		Ping: (options) ->
			method = "#{@_API}.Ping"
			return @
			
		###
		# Change the client-specific configuration.
		# @permission ControlNotify
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#JSONRPC.SetConfiguration
		#
		# @var [ object notifications ]
		#          [ Optional.Boolean gui = null ]
		#          [ Optional.Boolean other = null ]
		#          [ Optional.Boolean input = null ]
		#          [ Optional.Boolean videolibrary = null ]
		#          [ Optional.Boolean audiolibrary = null ]
		#          [ Optional.Boolean playlist = null ]
		#          [ Optional.Boolean system = null ]
		#          [ Optional.Boolean player = null ]
		#          [ Optional.Boolean application = null ]
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback Configuration
		# @return APIBase
		###
		SetConfiguration: (options) ->
			method = "#{@_API}.SetConfiguration"
			return @
			
		###
		# Retrieve the JSON-RPC protocol version.
		# @permission ReadData
		# @see http://wiki.xbmc.org/index.php?title=JSON-RPC_API/v6#JSONRPC.Version
		#
		# @var object | function callback
		# @var [ object context ] The context to bind 'this' to in the callback
		# @callback { nteger minor, integer patch, integer major }
		# @return APIBase
		###
		Version: (options) ->
			method = "#{@_API}.Version"
			return @
			