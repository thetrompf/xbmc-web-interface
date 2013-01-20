define [
], () ->
	###
	# The XBMC Client base.
	###
	class ClientBase

		###
		# Constructs the xbmc client.
		# @param string host
		# @param string | integer port
		# @param string protocol
		# @return ClientBase
		###
		constructor: (host, port, protocol) ->
			throw new Error "The constructor must be implemented."

		###
		# Connect if not connected or ensure the server is stil responding.
		# e.g. in an ajax JSONRPC client is implemented, then this method, should check if the server is still responding.
		# or if implementing a WebSocket client then this method should connect to the server.
		# and reset the reconnect counter and the setTimeout callback.
		# @return ClientBase
		###
		connect: () ->
			throw new Error "The connect method must be implemented."


		###
		# Sends a message to the xbmc server.
		# @param object msg
		# @param object | function callback If a function is provided, it is treated as a success callback, if a hash is provided, then use the keys: success and error for defining such.
		# @param [ object context ]
		# @return ClientBase
		###
		send: (msg, callbacks) ->
			throw new Error "The send method must be implemented."

		###
		# Bind a callback to a notification.
		# @param string event
		# @param function callback
		# @param [ object context ]
		# @return ClientBase
		###
		bind: (event, callback, context) ->
			throw new Error "The bind method must be implemented."

		###
		# Unbind a callback from an event.
		# @param string event
		# @param function callback
		# @return ClientBase
		###
		unbind: (event, callback) ->
			throw new Error "The unbind method must be implemented."

		###
		# Unbind all notifications.
		# If no event specified, then unbind all callbacks. 
		# @param [ string event ]
		# @return CLientBase
		###
		unbindAll: (event) ->
			throw new Error "The unbindAll method must be implemented."