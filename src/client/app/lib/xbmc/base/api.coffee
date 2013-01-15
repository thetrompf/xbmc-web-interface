define [
	"jquery"
	"xbmc/base/client"
], ($, ClientBase) ->

	class APIBase

		_API: null
		
		client: null

		eventBindings: null
		events: []

		_getEvent: (event) -> 
			e = event.split "."
			throw new Error "Invalid event namespace, you cannot nest namespaces: #{event}" if e.length > 2
			res = {}
			if e.length is 1
				res.namespace = null
				res.event = e[0]
			else
				res.namespace = e[1]
				res.event = e[0]
			return res
		
		constructor: (@client) ->
			unless @client instanceof ClientBase
				throw new Error "The client must be an instanceof ClientBase"
			@_API = @constructor.name
			
			# setting up event bindings objects.
			@eventBindings = []
			return @

		bind: (event, callback, context) ->
			e = @_getEvent event
			throw new Error "No such event: #{e.event}, events available: #{@events}" unless _.contains @events, e.event
			cbObj = 
				callback: callback
				namespace: e.namespace
				event: e.event

			@eventBindings.push cbObj
			@client.bind "#{@_API}.#{e.event}", callback, context
			return @

		unbind: (event, callback) ->
			unbind = []
			if (event.indexOf ".") < 0
				e = _.contains @events, event
				if e
					eObj = { event: event, namespace: null }
				else
					eObj = { namespace: event }
			else
				eObj = @_getEvent event
				e = _.contains @events, eObj.event
			
			throw new Error "No such event: #{event.event}" if not e and not eObj.namespace?
			if callback?
				eObj.callback = callback
				unbind = _.where @eventBindings, eObj
			else if not e and eObj.namespace?
				unbind = _.where @eventBindings, { namespace: eObj.namespace }
			else
				throw new Error "Case unhandled"

			for eventObj in unbind
				@client.unbind "#{@_API}.#{eventObj.event}", eventObj.callback
			return @
		
		unbindAll: () ->
			for eventObj in @eventBindings
				if (idx = @eventBindings.indexOf eventObj) < 0
					throw new Error "The event doesn't exist anymore, this shouldn't happen"
				@eventBindings.splice idx, 1
				@client.unbind "#{@_API}.#{eventObj.event}", eventObj.callback
			return @

		dispose: () ->
			@unbindAll()
			return @