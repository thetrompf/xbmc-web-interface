define [
	"base/viewmodel"
	"text!app/home/templates/home.html"
], (ViewModel, template) ->
	class HomeViewModel extends ViewModel

		bindingContext: "#main-container"
		template: template
		template = null

		self = null

		properties: () ->
			title: @observable "Home"
			name: @observable ""
			names: @observable []
			subpageAlert: @observable no

		computedProperties: () ->
			shortName: @computed () -> @name().length < 20

		addHandler: () ->
			@names.push name: @name()
			@name ""

		removeHandler: () -> self.names.remove @

		initialize: (options) -> self = @
		removeAlert: () -> @subpageAlert no
		subpage: () -> @subpageAlert yes