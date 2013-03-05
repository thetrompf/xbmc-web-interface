define [
	"base/viewmodel"
	"text!app/home/templates/home.html"
	"text!app/home/templates/inner.html"
], (ViewModelBase, template) ->
	'use strict'
	class HomeViewModel extends ViewModelBase

		ENTER = 13
		ESC   = 27
		END   = 35
		HOME  = 36
		UP    = 38
		DOWN  = 40

		bindingContext: "#main-container"
		template      : template
		template      = null
		self          = null

		properties: () ->
			menuEntries: @observable [
				href: '/movies'
				html: '<span class="underline">M</span>ovies'
			,
				href: '/tvshows'
				html: '<span class="underline">T</span>V Shows'
			,
				href: '/music'
				html: 'M<span class="underline">u</span>sic'
			,
				href: '/settings'
				html: '<span class="underline">S</span>ettings'
			]
			selectedEntry: @observable null

		initialize: (opts) ->
			@_.map do @menuEntries, (e) =>
				e.selected = @observable false

		initEventHandlers: () ->
			@$(document).on "keydown.home", (e) =>
				if @_.contains [UP, DOWN], e.keyCode
					do e.preventDefault
					do e.stopPropagation
				switch e.keyCode
					when UP
						do @scrollUp
						return false
					when DOWN
						do @scrollDown
						return false

			@$(document).on "keyup.home", (e) =>
				if @_.contains [HOME,END,ENTER,ESC], e.keyCode
					do e.preventDefault
					do e.stopPropagation
				switch e.keyCode
					when HOME
						@scrollUp -1
						return false
					when END
						@scrollDown -1
						return false
					when ENTER
						do @select
						return false
					when 77 # M
						@highlightMenuEntry @menuEntries()[0]
						return do @select
					when 84 # T
						@highlightMenuEntry @menuEntries()[1]
						return do @select
					when 85 # U
						@highlightMenuEntry @menuEntries()[2]
						return do @select
					when 83 # S
						@highlightMenuEntry @menuEntries()[3]
						return do @select

		bindingsApplied: () ->
			@initEventHandlers()

		select: () ->
			return unless (e = @selectedEntry())?
			@options.router.setLocation e.href

		scrollUp: (interval = 1) ->
			m = do @menuEntries
			s = do @selectedEntry
			if interval is -1 #HOME
				menuEntry = @_.first m
			else if not s? or (i = @_.indexOf m, s) is 0
				menuEntry = @_.last m
			else
				menuEntry = if not ((i = i - interval) < 0) then m[i] else @_.first m
			@highlightMenuEntry menuEntry

		scrollDown: (interval = 1) ->
			m = do @menuEntries
			s = do @selectedEntry
			if interval is -1 #END
				menuEntry = @_.last m
			else if not s? or (i = @_.indexOf m, s) is m.length - 1
				menuEntry = @_.first m
			else
				menuEntry = if not ((i = i + interval) > m.length - 1) then m[i] else @_.last m
			@highlightMenuEntry menuEntry

		highlightMenuEntry: (menuEntry) ->
			@selectedEntry()?.selected false
			menuEntry.selected true
			@selectedEntry menuEntry

		dispose: () ->
			@$(document).off ".home"
			super
