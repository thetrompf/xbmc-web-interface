define [
	"base/viewmodel"
	"text!app/settings/templates/settings.html"
], (ViewModel, template) ->
	class SettingsViewModel extends ViewModel

		bindingContext: "#main-container"
		template: template
		template = null

		properties: () ->
			title: @observable "Settings"