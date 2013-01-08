define [
	"base/viewmodel"
], (ViewModel) ->
	class HomeViewModel extends ViewModel

		properties: () ->
			title: @observable "Home"
			string: @observable "string"
			array: @observable [ "elm1", "elm2" ]
			minLength: 6

		computedProperties: () ->
			shortString: @computed () ->
				@string().length < @minLength

		initialize: (options) ->
			super
		
		render: () ->

		dispose: () ->
			super