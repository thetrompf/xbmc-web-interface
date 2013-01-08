define [
	"base/viewmodel"
], (ViewModel) ->
	class SettingsViewModel extends ViewModel

		properties: () ->
			title: @observable "Settings"