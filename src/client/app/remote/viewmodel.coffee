define [
	"base/viewmodel"
], (ViewModel) ->
	class RemoteViewModel extends ViewModel

		properties: () ->
			title: @observable "Remote"