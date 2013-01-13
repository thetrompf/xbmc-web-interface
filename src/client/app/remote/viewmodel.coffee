define [
	"base/viewmodel"
	"text!app/remote/templates/remote.html"
], (ViewModel, template) ->
	class RemoteViewModel extends ViewModel

		bindingContext: "#main-container"
		template: template
		template = null

		properties: () ->
			title: @observable "Remote"