define [
	"jquery"
	"underscore"
	"knockout"
	"base/router"
], ($, _, ko, Router) ->
	class ViewModelBase
		
		#####################
		# _for internal use #
		#####################
		
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

		#############
		# Utilities #
		#############

		$: $   # jQuery
		_: _   # underscore
		ko: ko # knockout
		
		##########################################
		# ViewModel control variables            #
		# override these for different behavior. #
		##########################################

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

		# This will make the view model to always dispose,
		# even an url change will cause that this view model
		# will be hit again.
		# Can be changed on-the fly, the property will be read
		# when the router hits a new URL.
		alwaysDispose: false
		
		# when using templates you can deside, whether to wrap the template in an element
		# if yes, then you can deside which element you want to wrap the template in
		wrapTemplate: no
		tagName: 'div'   # string tag selector

		########################
		# Reference variableds #
		########################

		# holds the dom node reference to the root node of the template
		el: null
		# holds the jQuery reference to the root node of the template
		$el: null

		###############
		# Observables #
		###############
		url: null # observable

		###
		# Create an observable from val, if an array is given then return a ko.observableArray
		# anything else returns a ko.observable.
		# @param mixed The value to turn into an observable
		# @return ko.observable|ko.observableArray
		###
		observable: (val) ->
			return @ko.observableArray val if @_.isArray val
			@ko.observable val

		###
		# Create an computed observable.
		# @see http://knockoutjs.com/documentation/computedObservables.html for advanced usage, e.g. writeable computed observables
		# @param Function|Object fn The function or hash to make a computed observable of.
		# @param Object context Which context to bind the computed observable's this to.
		# @param Object options A hash with additional options.
		# @return ko.computed
		###
		computed: (fn, context = @, options = {}) ->
			@ko.computed fn, context, options

		###
		# Creates a subscription of an observable, this is often not necessary, use computed instead.
		# @param ko.observable|ko.computed observable The observable to subscribe to.
		# @param Function callback The callback to call when the subscription getting notified.
		# @param Object context=this The context to set as this in the subscription.
		# @param String event=change The event to getting notification about.
		###
		subscribe: (observable, callback, context = @, event) ->
			observable.subscribe callback, context, event

		###
		# The properties of the viewmodel.
		# @param ... The arguments passed to the viewmodel constructor.
		# @return Object The properties of the viewmodel.
		###
		properties: () -> {}

		###
		# The computed propeties of the viewmodel.
		# @param ... The arguments passed to the viewmodel constructor.
		# @return Object The computed properties of the viewmodel.
		###
		computedProperties: () -> {}

		###
		# The custom subscriptions of the viewmodel.
		# NB! remember to use @subscribe, instead of ko.subscribe,
		# in order to setting the correct context, without having to pass it yourself.
		# @param ... The arguments passed to the viewmodel constructor.
		# @return Object An object hash of the subscriptions.
		###
		subscriptions: () -> {}

		###
		# constructor
		# DO NOT OVERRIDE UNLESS
		# YOU KNOW WHAT YOU ARE DOING!
		# Please override the initialize/afterInitilize instead.
		# @param Object options The options are available on this.options
		# @param ... Every argument inclusive options is passed to properties, computedProperties, subscriptions, initialize and afterInitialize
		# @return void
		###
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
			
			################
			# Initializing #
			################

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

		###
		# Attach the template to DOM
		# @param mixed container=this.bindingContext The container to insert the compiled template into.
		# @param String method Which method to use to insert the compiled template with.
		# @return void
		# @throws Error If the view hasn't been rendered.
		# @throws Error If using illegal attach method.
		# @throws Error If the element you want to attach to the DOM is not a jQuery element.
		###
		attachToDOM: (container = @bindingContext, method = 'append') ->
			$el = _resolveContainer.call _self, container
			throw new Error "You cannot attach to DOM before rendered" unless @rendered()
			throw new Error "method must be one of the following: #{_DOMAttachMethods}" unless _.find _DOMAttachMethods, (e) -> e is method
			throw new Error "$el must be a jQuery element" unless $el instanceof @$
			$el[method] @$el
			_isAddedToDOM = yes
			@addedToDOM()

		#################
		# ViewModel API #
		#################

		###
		# Initilize is called after construction.
		# The @$el is not available yet
		# so absolutely initialization work is done here.
		# @param ... The arguments passed to the viewmodel contructor.
		###
		initialize: (options) ->

		###
		# After initialize
		# The @$el is now available for event handling setup.
		# @param ... The arguments passed to the viewmodel constructor.
		###
		afterInitialize: (options) ->

		###
		# The is the step where you can do the last minute dom
		# manipulation of the @$el node before it is inserted to the DOM.
		# @return void
		# @throws Error if calling render when no template is defined.
		###
		render: () ->
		
		###
		# Called when inserted to the DOM.
		# @return void
		###
		addedToDOM: () ->

		###
		# Called when ko.applyBinding has been applied on the ViewModel.
		# @return void
		###
		bindingsApplied: () ->

		###
		# jQuery template "engine", having same interface as handlebars
		# compile returns a function, that takes context as argument, and returns compiled HTML
		# @param String html The template string to compile
		# @return Funciton That evaluates to a string with the context resolved.
		###
		compile: (html) -> (context) -> html

		###
		# Makes this viewmodel aware of another viewmodel to dispose, when this one gets disposed.
		# @param ViewModelBase viewModel The viewmodel to attach.
		# @return void
		###
		attachViewModel: (viewModel) ->
			_viewModels.push viewmodel

		###
		# Detach viewmodel from the nested viewmodel array,
		# and return it.
		# NB! the view model will not be disposed.
		# so you will have to do that manually.
		# @param ViewModelBase viewModel The viewModel to detach.
		# @return ViewModelBase The detached viewmodel.
		###
		detachViewModel: (viewModel) ->
			if (idx = _.indexOf _viewModels, viewmodel) > -1
				vm = _viewModels[idx]
				_viewModels.splice idx, 1
				return vm

		###
		# Dispose viewmodel.
		# Setting the this.disposed to true.
		# @param ViewModelBase The previous active viewmodel.
		# @return void
		###
		dispose: (previousViewModel) ->
			unless previousViewModel is @
				for vm in _viewModels
					vm.dispose?(previousViewModel)
				for key of _subscriptions
					_subscriptions[key].dispose()
				@$el?.remove()
				@disposed true
