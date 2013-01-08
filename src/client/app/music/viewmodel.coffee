define [
	"base/viewmodel"
], (ViewModel) ->
	class MusicViewModel extends ViewModel

		properties: () ->
			title: @observable "Music"