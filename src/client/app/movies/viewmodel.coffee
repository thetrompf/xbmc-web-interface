define [
	"base/viewmodel"
], (ViewModel) ->
	class MoviesViewModel extends ViewModel

		properties: () ->
			title: @observable "Movies"