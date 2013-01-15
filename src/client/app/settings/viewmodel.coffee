define [
	"base/viewmodel"
	"text!app/settings/templates/settings.html"
], (ViewModel, template) ->
	class SettingsViewModel extends ViewModel

		bindingContext: "#main-container"
		template: template
		template = null

		properties: (options) ->
			options.searchPlaceholder "Search settings..."
			title: @observable "Settings"

		subscriptions: (options) ->
			searchDelayed: @subscribe(options.searchDelayed, (newValue) ->
				if newValue.length > 3
					console.log "Search settings: #{newValue}"
			)