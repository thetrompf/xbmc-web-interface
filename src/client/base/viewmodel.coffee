define [
	"jquery"
	"underscore"
	"knockout"
], ($, _, ko, Router) ->

	uid = 0

	###
	# Used as a binding context.
	# Delivers base functionality for a ViewModel.
	# Can be used with and without a template.
	# @uses jQuery | _ | ko | Router
	###
	class ViewModel

		#####################
		# _for internal use #
		#####################

		###
		# The user defined render function
		# @var Function | null
		###
		_render: null

		###
		# The user defined initialize function
		# @var Function | null
		###
		_initialize: null

		###
		# Whether or not the viewmodel's template is added to DOM
		# @var ko.observable<Boolean> | null
		###
		_isAddedToDOM: null

		###
		# Whether or not the ViewModel bindings has been applied to the template
		# @var ko.observable<Boolean> | null
		###
		_isBindingsApplied: null

		###
		# The supported methods to add template to DOM (jQuery methods)
		# @var Array<String>
		###
		_DOMAttachMethods: ['append', 'prepend']

		###
		# Holds the viewModels attach from here.
		# these should be disposed when this is view model is disposed.
		# @var ko.observableArray<ViewModelBase> | null
		###
		_viewModels: null

		###
		# Holds the subscriptions attach to the viewmodel.
		# This is necessary in order to get disposal to work properly.
		# @var Object<String, ko.subscriptions> | null
		###
		_subscriptions: null

		###
		# Holds the unique id of the view model, instanciated upon construction.
		# @var String | null
		###
		_uid: null

		#############
		# Utilities #
		#############

		###
		# jQuery reference on the ViewModel
		# @var jQuery
		###
		$: $

		###
		# Underscore reference on the ViewModel
		# @var _
		###
		_: _

		###
		# Knockout reference on the ViewModel
		# @var ko
		###
		ko: ko

		###############################
		# ViewModel control variables #
		###############################

		###
		# Whether or not the ViewModels template has been rendered.
		# @var ko.observable<Boolean> | null
		###
		rendered: null

		###
		# Whether the viewModel is disposed.
		# @var ko.observable<Boolean> | null
		###
		disposed: null

		###
		# The template to compile, as a string,
		# you cannot call render if no template is defined.
		#
		# But you could give an empty string,
		# and then use the wrap template property,
		# to still have an $el to work on.
		# @var String | null
		####
		template: null

		###
		# Whether or not to automatically render the template after
		# viewmodel initialization
		# @var Boolean
		###
		autoRender: yes

		###
		# Whether or not to automatically attach the template to DOM
		# after the template has been rendered.
		# @var Boolean
		###
		autoAttachToDOM: yes

		###
		# The DOM node to apply this ViewModel bindings on.
		# @see resolveContext
		#
		# * String - CSS selector
		# * DOMNode
		# * jQuery element
		# * Function - returning one of the above.
		# @var String | jQuery | Function | DOMNode | null
		###
		bindingContext: null

		###
		# Where to insert the template into the DOM.
		#
		# NB! If no container is defined, then the bindingContext is used.
		# @see resolveContext
		#
		# * String - CSS selector
		# * DOMNode
		# * jQuery element
		# * Function - returning one of the above.
		# @var String | jQuery | Function | DOMNode | null
		###
		container: null

		###
		# This will make the view model to always dispose,
		# even an url change will cause that this view model
		# will be hit again.
		# Can be changed on-the fly, the property will be read
		# when the router hits a new URL.
		# @var Boolean
		###
		alwaysDispose: no

		###
		# When using templates you can deside, whether to wrap the template in an element
		# if yes, then you can deside which element you want to wrap the template in
		# @var Boolean
		###
		wrapTemplate: no

		###
		# A tag name to create a dom node from.
		# NB! This is only used when wrapTemplate is enabled.
		# @var String
		###
		tagName: 'div'

		###
		# A space seperated class list to add to the wrapper element.
		# NB! This is only used when wrapTemplate is enabled.
		# @var String | null
		###
		className: null

		###
		# A string id to add to the wrapped element.
		# NB! This is only used when wrapTemplate is enabled.
		# @var String | null
		###
		id: null

		########################
		# Reference variableds #
		########################

		###
		# Holds the DOMNode reference to the root node of the template.
		# @var DOMNode | null
		###
		el: null

		###
		# Holds the jQuery reference to the root node of the template.
		# @var jQuery | null
		###
		$el: null

		###############
		# Observables #
		###############

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

			# initializing the viewmodel's unique id.
			@_uid = "vm#{uid++}"

			# intializing sub-viewmodels-map.
			@_viewModels = []

			# initializing observable @disposed property.
			@disposed = @observable no

			# initializing observable @rendered property.
			@rendered = @observable no

			@_isAddedToDOM = @observable false
			@_isBindingsApplied = @observable false

			# setting up properties
			@_.extend @, @properties arguments...
			@_.extend @, @computedProperties arguments...
			@_subscriptions = @subscriptions arguments...
			@_.extend @, @_subscriptions

			# setting up observable of automatic callback calling when view is inserted into DOM
			@computed () ->
				if _self._isAddedToDOM() is yes
					_self.addedToDOM()
					_self.applyBindings() unless _self._isBindingsApplied() is yes
					for vm in _self._viewModels
						vm.attachToDOM() if vm.autoAttachToDOM

			@computed () ->
				if _self._isBindingsApplied() is yes
					_self.bindingsApplied()

			################
			# Initializing #
			################

			# debugger

			# setting up the wrapped intialize function.
			@_initialize = @initialize
			@initialize = (options) ->
				_self._initialize.call _self, options
				if _self.wrapTemplate
					_self.$el = _self.$ "<#{@tagName} />"
					_self.$el.addClass _self.className if _self.className?
					_self.$el.attr 'id', _self.id if _self.id?
					_self.el = _self.$el.get 0
				else if _self.template?
					# This only works if the template only has one root element.
					_self.$el = _self.$ (_self.compile _self.template) _self
					throw new Error "Only one root element is allowed when rendering templates without wrapping" if _self.$el.length > 1
					_self.el = _self.$el.get 0
				else if _.isString _self.$el
					_self.$el = _self.$ _self.$el
					_self.el = _self.$el.get 0
				_self.afterInitialize options

			# setting up the wrapped render function
			@_render = @render
			@render = () ->
				throw new Error "You have to define a template to use render" unless _self.template?
				_self.$el.append (_self.compile _self.template) _self if _self.wrapTemplate
				_self._render.call _self
				_self.rendered yes

				# applying context to element if the binding context is not in the DOM.
				$bindingContext = _self.resolveContext _self.bindingContext
				_self.applyBindings() unless _self.elementInDOM $bindingContext

				if _self.autoAttachToDOM
					# setting up the container for where the template should be rendered
					_self.attachToDOM()

			# call initialize
			@initialize @options

			# render if autoRender is enabled
			if @autoRender
				@render()

		###
		# Resolves a context to a jQuery object.
		# NB! function should resolve to a string,jQuery element or DOMnode.
		# @param Function | String | jQuery | DOMNode context
		# @return jQuery | null
		###
		resolveContext: (context) ->
			return @resolveContext context.call @ if _.isFunction context
			return @$ context if _.isString context
			return context if context instanceof @$
			return @$ context if context?.nodeType?
			return null

		###
		# Whether or not the element is in the DOM
		# @param jQuery | DOMNode
		# @return Boolean
		###
		elementInDOM: (element) ->
			element = element.get(0) if element instanceof @$
			while element = element.parentNode
				if element is document
					return true
			return false

		###
		# Attach the template to the DOM.
		# @param mixed container=this.bindingContext The container to insert the compiled template into.
		# @param String method='append' Which method to use to insert the compiled template with.
		# @return void
		# @throws Error If the view hasn't been rendered.
		# @throws Error If using illegal attach method.
		# @throws Error If the element you want to attach to the DOM is not a jQuery element.
		###
		attachToDOM: (container = @container, method = 'append') ->
			return if @_isAddedToDOM()
			container = @bindingContext unless container?
			$el = @resolveContext.call @, container
			throw new Error "You cannot attach to DOM before rendered" unless @rendered()
			throw new Error "method must be one of the following: #{@_DOMAttachMethods}" unless _.find @_DOMAttachMethods, (e) -> e is method
			throw new Error "$el must be a jQuery element" unless $el instanceof @$
			$el[method] @$el
			if @elementInDOM $el
				@_isAddedToDOM yes

		###
		# Applying bindings to bindingsContext.
		# When using nested viewmodels, you should initialize the nested viewmodel
		# inside this callback.
		# @return void
		###
		applyBindings: () ->
			$bindingContext = @resolveContext @bindingContext
			@ko.applyBindings @, $bindingContext.get 0
			@_isBindingsApplied yes

		###
		# Applies the viewmodel's uid to the events as namespace.
		# @var Object | String events
		# @return Object | String
		###
		applyViewModelIdToEvents: (events) ->
			if _.isString events
				return "#{events}.#{@_uid}" unless events.indexOf "." > -1 # if the event already contain a namespace do nothing.
				return events
			else if _.isObject
				res = {}
				_.map events, (key, value) =>
					if events.indexOf "." > -1
						res["#{events}.#{@_uid}"] = value
					else
						res[events] = value
				return res
			else
				throw new Error "Unsupport event type: #{typeof events}"

		#################
		# ViewModel API #
		#################

		###
		# Initilize is called after construction.
		# The this.$el is not available yet
		# so absolutely initialization work is done here.
		# @param ... The arguments passed to the viewmodel contructor.
		###
		initialize: (options) ->

		###
		# After initialize
		# The this.$el is now available for event handling setup.
		# @param ... The arguments passed to the viewmodel constructor.
		###
		afterInitialize: (options) ->

		###
		# The is the step where you can do the last minute dom
		# manipulation of the this.$el node before it is inserted to the DOM.
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
		# Called when ko.applyBindings has been applied on the ViewModel.
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
		# Subscribe to an event, proxy to jQuery.on, except for some home-cooking event namespacing
		# added to it, events subscribe through here, are automatically unsubscribed upon disposal.
		# @param Object | String events
		# @param [ String selector ]
		# @param [ Anything data ]
		# @param Function handler(event)
		# @return jQuery
		###
		on: (events, selector, data, handler) ->
			@$el.on (@applyViewModelIdToEvents events), selector, data, handler

		###
		# Unsubscribe to an event, proxy to jQuery.off, except for some home-cooking event namespacing
		# added to it.
		# @param Object | String events
		# @param String selector
		# @param [ Function handler(event) ]
		# @return jQuery
		###
		off: (events, selector, handler) ->
			@$el.off (@applyViewModelIdToEvents events), selector, handler

		###
		# Makes this viewmodel aware of another viewmodel to dispose, when this one gets disposed.
		# @param ViewModelBase viewModel The viewmodel to attach.
		# @return void
		###
		attachViewModel: (viewModel) ->
			unless @_isBindingsApplied()
				throw new Error "You cannot attach an inner view model, without bindings are applied on out context"
			@_viewModels.push viewModel

		###
		# Detach viewmodel from the nested viewmodel array,
		# and return it.
		# NB! the view model will not be disposed.
		# so you will have to do that manually.
		# @param ViewModelBase viewModel The viewModel to detach.
		# @return ViewModelBase The detached viewmodel.
		###
		detachViewModel: (viewModel) ->
			if (idx = _.indexOf @_viewModels, viewModel) > -1
				vm = @_viewModels[idx]
				@_viewModels.splice idx, 1
				return vm

		###
		# Dispose viewmodel.
		# Setting the this.disposed to true.
		# @return void
		###
		dispose: () ->
			for vm in @_viewModels
				vm.dispose?()
			for key of @_subscriptions
				@_subscriptions[key].dispose()
			@$el?.remove()
			@off ".#{@_uid}"
			@disposed true
