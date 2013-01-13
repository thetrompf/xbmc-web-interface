define [
	"jquery"
	"underscore"
	"knockout"
	"base/router"
], ($, _, ko, Router) ->
	class ViewModelBase
		
		###
		# _for internal use
		###
		
		# holds referenced to the original methods from the sub class
		_render = null
		_initialize = null

		# is true when the compiled template is added to dom.
		_isAddedToDOM = false

		# supported methods to add template to dom (jQuery methods)
		_DOMAttachMethods = ['append', 'prepend']
		
		# holds the viewModels attach from here.
		# these should be disposed when this is view model is disposed.
		_viewModels = [] # viewmodels

		# holds the subscriptions
		_subscriptions = null

		# see bindingContext property
		_resolveContainer = Router::resolveBindingContext

		# for bind the correct contexts, to the callbacks.
		_self = null

		###
		# Utilities
		###
		$: $   # jQuery
		_: _   # underscore
		ko: ko # knockout
		
		###
		# ViewModel control variables
		# override these for different behavior.
		###

		# observable, you can subscribe to when the template is rendered.
		rendered: null

		# url observable
		url: null

		# observable, whether the viewModel is disposed
		disposed: null

		# controlling properties
		template: null # html text string

		# whether to automatically render the template after
		# viewmodel initialization or not
		autoRender: true

		# whether to automatically attach the template to DOM
		# after the template has been rendered.
		autoAttachToDOM: true

		# can be a:
		# * string selector
		# * jQuery element
		# * function returning a jQuery element
		# 
		# It is here the template will be rendered in as well.
		bindingContext: null
		
		# when using templates you can deside, whether to wrap the template in an element
		# if yes, then you can deside which element you want to wrap the template in
		wrapTemplate: no
		tagName: 'div'   # string tag selector

		###
		# Reference variableds
		###

		# holds the dom node reference to the root node of the template
		el: null
		# holds the jQuery reference to the root node of the template
		$el: null

		###
		# Observables
		###
		url: null # observable

		observable: (val) ->
			return @ko.observableArray val if @_.isArray val
			@ko.observable val

		computed: (fn, context = @, opts = {}) ->

			@ko.computed fn, context, opts

		subscribe: (observable, callback, context, event) ->
			context = context || @
			observable.subscribe callback, context, event

		# return hash of observables
		properties: () -> {}
		# return hash of computed observables
		computedProperties: () -> {}
		# return hash of subscriptions
		# NB! remember to use @subscribe, instead of ko.subscribe
		# in order to setting the correct context, without having to pass it yourself.
		subscriptions: () -> {}

		# called after construction.
		# The @$el is not available yet
		# so absolutely initialization work is done here.
		# The constructor options is passed here as well
		initialize: (options) ->

		# The @$el is now available for event handling setup.
		afterInitialize: (options) ->

		# The is the step where you can do the last dom
		# manipulation of the @$el node before it is inserted to the DOM.
		render: () ->
		
		# called when inserted to the DOM.
		addedToDOM: () ->

		# called when ko.applyBinding has been applied on the ViewModel.
		bindingsApplied: () ->

		# constructor
		# DO NOT OVERRIDE UNLESS
		# YOU KNOW WHAT YOU ARE DOING!
		#
		# Please override the initialize/afterInitilize instead.
		constructor: (@options) ->

			# saving reference.
			_self = @

			# setting up observable url property.
			@url = @options.url
			delete @options['url']

			# initializing observable @disposed property.
			@disposed = @observable no

			# initializing observable @rendered property.
			@rendered = @observable no

			# setting up properties
			@_.extend @, @properties arguments...
			@_.extend @, @computedProperties arguments...
			_subscriptions = @subscriptions arguments...
			@_.extend @, _subscriptions
			
			###
			# Initializing 
			###

			# setting up the wrapped intialize function.
			_initialize = @initialize
			@initialize = (options) ->
				_initialize.call _self, options
				if @wrapTemplate
					@$el = @$ "<#{@tagName} />"
					@el = @$el.get 0
				else if @template?
					# This only works if the template only has one root element.
					@$el = @$ (@compile @template) @
					@el = @$el.get 0
				else if _.isString @$el
					@$el = @$ @$el
					@el = @$el.get 0
				@afterInitialize options

			# setting up the wrapped render function
			_render = @render
			@render = () ->
				throw new Error "You have to define a template to use render" unless @template?
				@$el.append (@compile @template) @ if @wrapTemplate
				_render.call _self
				@rendered yes

				$elm = _resolveContainer.call _self, @bindingContext
				@attachToDOM $elm if @autoAttachToDOM

			# call initialize
			@initialize @options

			# render if autoRender is enabled
			if @autoRender
				@render()

		# jQuery template "engine", having same interface as handlebars
		# compile returns a function, that takes context as argument, and returns compiled HTML
		compile: (html) -> (context) -> html

		# attach the template to DOM
		# call the addedToDOM callback when 
		attachToDOM: (container = @bindingContext, method = 'append') ->
			$el = _resolveContainer.call _self, container
			throw new Error "You cannot attach to DOM before rendered" unless @rendered()
			throw new Error "method must be one of the following: #{_DOMAttachMethods}" unless _.find _DOMAttachMethods, (e) -> e is method
			throw new Error "$el must be a jQuery element" unless $el instanceof @$
			$el[method] @$el
			_isAddedToDOM = yes
			@addedToDOM()

		# attach view model as a nested view model
		attachViewModel: (viewModel) ->
			_viewModels.push viewmodel

		# detach view model from the nested viewmodel array,
		# and return it.
		#
		# NB! the view model will not be disposed.
		# so you will have to do that manually.
		detachViewModel: (viewModel) ->
			if (idx = _.indexOf _viewModels, viewmodel) > -1
				vm = _viewModels[idx]
				_viewModels.splice idx, 1
				return vm

		# dispose viewmodel
		dispose: (previousViewModel) ->
			unless previousViewModel is @
				for vm in _viewModels
					vm.dispose?(previousViewModel)
				for key of _subscriptions
					_subscriptions[key].dispose()
				@$el?.remove()
				@disposed true
