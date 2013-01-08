define [
	"jquery"
	"underscore"
	"knockout"
], ($, _, ko) ->
	class ViewModelBase

		$: $
		_: _
		ko: ko

		template: null
		el: null
		$el: null

		properties: () -> {}
		computedProperties: () -> {}

		constructor: (@options) ->
			@_.extend @, @properties arguments...
			@_.extend @, @computedProperties arguments...
			@initialize @options
			@afterInitialize @options
			if @template?
				@render()
				@afterRender()

		initialize: (options) ->
		afterInitialize: (options) ->
		render: () ->
		afterRender: () ->

		observable: (val) ->
			return @ko.observableArray val if @_.isArray val
			@ko.observable val

		computed: (fn, opts = {}) -> @ko.computed fn, @, opts

		dispose: () ->
			@$el?.remove()