define [
	"base/viewmodel"
	"text!app/music/templates/music.html"
], (ViewModel, template) ->
	class MusicViewModel extends ViewModel

		bindingContext: "#main-container"
		template: template
		template = null

		properties: (options) ->
			options.searchPlaceholder "Search music..."
			title: @observable "Music"

		subscriptions: (options) ->
			searchDelayed: @subscribe(options.searchDelayed, (newValue) ->
				if newValue.length > 3
					console.log "Search music: #{newValue}"
			)