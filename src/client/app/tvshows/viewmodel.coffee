define [
	"base/viewmodel"
], (ViewModel) ->
	class TVShowsViewModel extends ViewModel

		bindingContext: "#main-container"

		properties: () ->
			title: @observable "TV Shows"