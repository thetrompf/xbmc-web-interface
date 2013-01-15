define [
	"base/viewmodel"
	"text!app/remote/templates/remote.html"
], (ViewModel, template) ->
	class RemoteViewModel extends ViewModel

		bindingContext: "#main-container"
		template: template
		template = null

		properties: (options) ->
			options.searchPlaceholder "Search remote..."
			title: @observable "Remote"

		subscriptions: (options) ->
			searchDelayed: @subscribe(options.searchDelayed, (newValue) ->
				if newValue.length > 3
					console.log "Search remote: #{newValue}"
			)