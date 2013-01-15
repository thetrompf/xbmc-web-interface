define [
	"underscore"
	"base/router"
	"app/routes"
	"base/viewmodel"
], (_, Router, routes, ViewModelBase) ->
	class TopmenuViewModel extends ViewModelBase

		# autoRender is false, because the view is already in the DOM
		# which is why $el is a string, that describes a selector matching the root element of the view
		autoRender: false
		$el: "#topmenu"
		bindingContext: "#topmenu"

		properties: (options) ->
			menu: @observable [
				link: "/home"
				label: "Home"
				exact: ["/"]
			,
				link: "/movies"
				label: "Movies"
			,
				link: "/tvshows"
				label: "TV Shows"
			,
				link: "/music"
				label: "Music"
			,
				link: "/remote"
				label: "Remote"
			,
				link: "/settings"
				label: "Settings"
			]
			search: @observable ""
			searchPlaceholder: @observable ""
			url: options.url

		computedProperties: (options) ->
			self = @
			searchDelayed: (@computed self.search).extend (throttle: 300)

		startsWith: (str, starts) ->
			return true if starts is ''
			return false unless str? or starts? 
			str = String str
			starts = String starts
			return str.length >= starts.length and (str.slice 0, starts.length) is starts

		afterInitialize: (options) ->
			@initMenu @menu()
			@applyBindings()
			@initEventHandlers()

		initEventHandlers: () ->
			@$("#navbar-search-form").submit (e) =>
				e.preventDefault()
				e.stopPropagation()
				return false

		initMenu: (menu) ->
			that = @
			for entry in menu
				entry.active = @computed () ->
					return false unless (url = that.url())?
					url = "/#{url}" unless url[0] is "/"
					return true if that.startsWith url, @link
					if _.isArray @match
						for m in @match
							return true if that.startsWith url, m
					if _.isArray @exact
						for e in @exact
							return true if url is e
					return false
				, entry

	class Application

		_(@.prototype).extend Router.prototype
		topmenu: null

		constructor: (args) ->
			@topmenu = new TopmenuViewModel url: @url
			options =
				url: @url
				search: @topmenu.search
				searchDelayed: @topmenu.searchDelayed
				searchPlaceholder: @topmenu.searchPlaceholder
			@initRouter routes, options