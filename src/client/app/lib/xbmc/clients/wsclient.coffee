define [
	"jquery"
	"underscore"
	"knockout"
	"xbmc/base/client"
], ($, _, ko, ClientBase) ->

	###
	# The actual WSClient.
	# @extends ClientBase
	###
	class _WSClient extends ClientBase

		###
		# Request status'
		# @const CREATED The request callback created state, the callback has been created, but the request has not yet been made.
		# @const SENT The request has now been made, and now waits for the server to answer, so we can execute the callback.
		###
		CREATED = 0
		SENT = 1

		###
		# Server info.
		# @var string | null The websocket host.
		# @var integer | string | null The connection port.
		###
		_host = null
		_port = null

		###
		# @var object The request callback queue.
		###
		_queue = {}

		###
		# @var object The notification events subscription queue.
		###
		_events = {}

		###
		# @var string The request identifier prefix.
		###
		_prexix = "xbmc-web-interface-"

		###
		# @var integer The request identifier sequencer.
		###
		_id = 0

		###
		# @var WebSocket | null The websocket.
		###
		_ws = null

		###
		# @var ko.observable | null
		###
		_connected = null

		###
		# Get unique request identifier.
		# @return string
		###
		_getId = () -> "#{_prexix}#{_id++}"

		###
		# Run queue of requests.
		# @return void
		###
		_runQueue = () ->
			for id, item of _queue
				if item.state is CREATED
					item.state = SENT
					_ws.send item.msg
			return @

		###
		# Run the a callback queue.
		# @param array callbacks
		# @param object msg
		###
		_runCallbacks = (callbacks, msg) ->
			for cbObj in callbacks
				if cbObj.context?
					cbObj.callback.call cbObj.context, msg
				else
					cbObj.callback msg
			return @

		###
		# Whether or not the web socket is connected.
		# @return boolean
		###
		isConnected: () ->
			return _connected()

		###
		# Constructs a xbmc websocket client.
		# @param string host
		# @param string port
		# @param [ string protocol ]
		# @return ClientBase
		###
		constructor: (host, port, protocol) ->
			return if _ws?
			_host = host
			_port = port
			_connected = ko.observable no

			# setting up handle after first connect
			# or a connect after a disconnect.
			_whenConnected = ko.computed () ->
				if _connected() is yes
					_runQueue()

		###
		# Connect if not connected.
		# @return ClientBase
		###
		connect: () ->
			unless @isConnected()
				_ws = new WebSocket "ws://#{_host}:#{_port}/jsonrpc"
				_ws.onmessage = @recieve
				_ws.onerror = (msg) ->
					console?.error "The websocket came back with an error", msg
				_ws.onopen = (msg) ->
					_connected yes
				_ws.onclose = (msg) =>
					_connected no
					rc = setTimeout () =>
						if _connected()
							clearTimeout rc
						else
							@connect()
							console?.info "Connection closed trying to reconnect in 5 seconds, ws://#{_host}:#{_port}/jsonrpc"
					, 5000
			return @

		###
		# Handling response from server.
		# @param _WSClient ws
		# @return void
		###
		recieve: (ws) =>
			msg = JSON.parse ws.data
			return @error msg if msg.error?
			return @success msg

		###
		# Handling success response from server.
		# @param object msg
		# @return void
		###
		success: (msg) ->
			if (q = _queue[msg.id])?
				if q.context?
					q.defer.resolveWith q.context, [msg.result]
				else
					q.defer.resolve msg.result
				delete _queue[msg.id]
			else
				# handle message without a deffered hooked up.
				# e.g. notifications
				console.log "Notifications", msg
				events = _events[msg.method]
				_runCallbacks events, msg.params.data if events?

			return @

		###
		# Handling error response from the server.
		# @param object msg
		# @return void
		###
		error: (msg) ->
			if (q = _queue[msg.id])?
				if q.context?
					q.defer.rejectWith q.context, [msg.error]
				else
					q.defer.reject msg.error
				delete _queue[msg.id]
			return @

		###
		# Send message to the xbmc server.
		# @param object msg
		# @param object | function callback success, error
		# @param [ object context ]
		# @return void
		###
		send: (msg, callback, context) ->
			id = _getId()
			msg["jsonrpc"] = "2.0"
			msg["id"] = id

			msg = JSON.stringify msg
			defer = $.Deferred()

			# treating callback as a success callback
			# if only a function is provided as callback
			if _.isFunction callback
				_callback = callback
				callback = {}
				callback.success = _callback

			throw new Error "A success callback has to be provided" unless callback.success?

			# setting up defered callbacks
			defer.fail callback.error if callback.error?
			defer.done callback.success

			# inserting queue item.
			_queue[id] =
				defer: defer
				msg: msg
				state: CREATED
				context: context

			# go ahead and send the message, if we already are connected.
			if @isConnected()
				_queue[id].state = SENT
				_ws.send msg

			return @

		###
		# Bind a callback to a notification.
		# @param string event Event is a prefix of the JSONRPC notification methods.
		# @param function callback(msg)
		# @param object context
		# @return ClientBase
		###
		bind: (event, callback, context) ->
			throw new Error "At least event and callback has to be provided" unless callback? and event?
			_events[event] = [] unless _events[event]?
			_events[event].push callback: callback, context: context
			return @

		###
		# Unbind a callback from an event.
		# @param string event
		# @param Funcion callback
		# @return ClientBase
		###
		unbind: (event, callback) ->
			throw new Error "Event and callback have to be provided" if not callback? and not event?
			return unless _events[event]?
			for cbObj in _events[event]
				if cbObj.callback is callback
					if (idx = _events[event].indexOf cbObj) < 0
						throw new Error "Event doesn't exist anymore, this shouldn't happen"
					_events[event].splice idx, 1
					if _events[event].length < 1
						delete _events[event]
			return @

		###
		# Unbind all notifications.
		# If no event specified, then unbind all callbacks.
		# @param [ string event ]
		# @return ClientBase
		###
		unbindAll: (event) ->
			_events = {} unless event?
			delete _events[event] if _events[event]?
			return @

	###
	# Proxy object, used for singleton creation of the _WSClient.
	###
	class WSClient

		###
		# @var _WSClient | null Holds the instance of the exiting connection.
		###
		_instance = null

		###
		# Creates a client, or returns an existing one if any.
		# @param [ string host="localhost" ] The hostname or IP.
		# @param [ string | integer port=9090 ] The network port, to connect to.
		# @param [ string protocol=null ] The protocol to connect to. NB! It is ignored in this client.
		# @return _WSClient
		###
		@get = (host, port, protocol) ->
			console.warn "Protocol choice has been ignored, ws:// is the only supported protocal by this client" if protocol?
			host = "localhost" unless host?
			port = 9090 unless port?
			return _instance if _instance?
			return _instance = (new _WSClient host, port, protocol).connect()

