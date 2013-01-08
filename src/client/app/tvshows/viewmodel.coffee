define [
	"base/viewmodel"
], (ViewModel) ->
	class TVShowsViewModel extends ViewModel

		properties: () ->
			title: @observable "TV Shows"