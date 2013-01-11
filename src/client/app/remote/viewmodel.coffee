define [
	"base/viewmodel"
], (ViewModel) ->
	class RemoteViewModel extends ViewModel

		bindingContext: "#main-container"

		properties: () ->
			title: @observable "Remote"