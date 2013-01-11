define [
	"base/viewmodel"
], (ViewModel) ->
	class MusicViewModel extends ViewModel

		bindingContext: "#main-container"

		properties: () ->
			title: @observable "Music"