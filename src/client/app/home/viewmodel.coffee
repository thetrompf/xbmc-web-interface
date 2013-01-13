define [
	"base/viewmodel"
	"text!app/home/templates/home.html"
	"text!app/home/templates/inner.html"
], (ViewModelBase, template, innerTemplate) ->
	class InnerViewModel extends ViewModelBase

		bindingContext: "#inner-viewmodel-test"
		template: innerTemplate
		innerTemplate = null
		autoRender: yes

		properties: () ->
			innerText: @observable "It is working with only one root element"

	class HomeViewModel extends ViewModelBase

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

		bindingsApplied: () ->
			inner = new InnerViewModel url: @url
			@attachViewModel inner
