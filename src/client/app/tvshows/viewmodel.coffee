define [
	"base/viewmodel"
	"text!app/tvshows/templates/tvshows.html"
], (ViewModelBase, template) ->
	class TVShowsViewModel extends ViewModelBase

		bindingContext: "#main-container"
		template: template
		template = null

		properties: (options) ->
			options.searchPlaceholder "Search tv shows..."
			title: @observable "TV Shows"

		subscriptions: (options) ->
			searchDelayed: @subscribe(options.searchDelayed, (newValue) ->
				if newValue.length > 3
					console.log "Search tv shows: #{newValue}"
			)