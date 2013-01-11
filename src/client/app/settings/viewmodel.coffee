define [
	"base/viewmodel"
], (ViewModel) ->
	class SettingsViewModel extends ViewModel

		bindingContext: "#main-container"

		properties: () ->
			title: @observable "Settings"