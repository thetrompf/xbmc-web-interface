define [
], () ->
	class ClientBase

		constructor: (host, port, protocol) ->
			throw new Error "Override this constructor"

		send: (msg, callbacks, context) ->
			throw new Error "Send must be implemented"