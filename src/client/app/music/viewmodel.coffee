define [
	"base/viewmodel"
	"text!app/music/templates/music.html"
], (ViewModel, template) ->
	class MusicViewModel extends ViewModel

		bindingContext: "#main-container"
		template      : template
		template      = null
		self          = null
