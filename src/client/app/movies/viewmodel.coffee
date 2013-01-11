define [
	"base/viewmodel"
	"text!app/movies/templates/movies.html"
], (ViewModel, template) ->
	class MoviesViewModel extends ViewModel

		bindingContext: "#main-container"
		wrapTemplate: true
		template: template
		template = null

		properties: () ->
			title: @observable "Movies"