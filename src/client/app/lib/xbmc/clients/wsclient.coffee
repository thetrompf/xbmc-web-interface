define [
	"jquery"
	"underscore"
	"knockout"
	"xbmc/base/client"
], ($, _, ko, ClientBase) ->
	class _WSClient extends ClientBase

		CREATED = 0
		SENT = 1

		_host = null
		_port = null

		_queue = {}

		_prexix = "xbmc-web-interface-"
		_id = 0
		_ws = null
		
		_connected = null

		getId = () -> "#{_prexix}#{_id++}"
		
		runQueue = () ->
			for id, item of _queue
				if item.state is CREATED
					item.state = SENT
					_ws.send item.msg

		isConnected: () ->
			return _connected()

		constructor: (host, port) ->
			_host = host
			_port = port
			_connected = ko.observable no
			_whenConnected = ko.computed () ->
				if _connected() is yes
					runQueue()

			return @

		connect: () ->
			unless @isConnected()
				_ws = new WebSocket "ws://#{_host}:#{_port}/jsonrpc"
				_ws.onmessage = @recieve
				_ws.onerror = (msg) ->
					console?.error "The websocket came back with an error", msg
				_ws.onopen = (msg) ->
					_connected yes
				_ws.onclose = (msg) ->
					_connected no
			return @

		recieve: (msg) =>
			msg = JSON.parse msg.data
			return @error msg if msg.error?
			if (q = _queue[msg.id])?
				if q.context?
					q.defer.resolveWith q.context, [msg.result]
				else
					q.defer.resolve msg.result
				delete _queue[msg.id]
			else
				# handle message without a deffered hooked up.
				# e.g. notifications
				debugger

		error: (msg) ->
			if (q = _queue[msg.id])?
				if q.context?
					q.defer.rejectWith q.context, [msg.error]
				else
					q.defer.reject msg.error
				delete _queue[msg.id]

		send: (msg, callbacks, context) ->
			id = getId()
			msg["jsonrpc"] = "2.0"
			msg["id"] = id
			msg = JSON.stringify msg
			defer = $.Deferred()
			defer.fail callbacks.error if callbacks.error?
			defer.done callbacks.success if callbacks.success?
			_queue[id] =
				defer: defer
				msg: msg
				state: CREATED
				context: context
			if @isConnected()
				_queue[id].state = SENT
				_ws.send msg

	class WSClient
		_instance = null
		@get = () ->
			return _instance if _instance?
			return _instance = (new _WSClient "localhost", "9090").connect()

