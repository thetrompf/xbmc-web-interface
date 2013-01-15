define [
], () ->
	class ClientBase
		send: (msg, callbacks, context) ->
			throw new Error "Send must be implemented"