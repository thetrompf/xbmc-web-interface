define [
	"xbmc/base/client"
], (ClientBase) ->

	class APIBase

		client: null
		limits:
			start: 0
			end: 20

		constructor: (@client) -> throw new Error "The client must be an instanceof ClientBase" unless @client instanceof ClientBase

		getLimits: (options) ->
			start: if options.limits.start? then options.limits.start else @limits.start
			end: if options.limits.end? then options.limits.end else @limits.end

		getCallbacks: (options) ->
			success: if options.success? then options.success else null
			error: if options.error? then options.error else null