define [
	"base/viewmodel"
	"text!app/tvshows/templates/tvshows.html"
], (ViewModelBase, template) ->
	class TVShowsViewModel extends ViewModelBase

		bindingContext: "#main-container"
		template      : template
		template      = null
		self          = null
