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
			names: @observable [
				name: "Brian K. Christensen"
			,
				name: "Kaare Hoff Skovgaard"
			,
				name: "Karina Haven Pedersen"
			]
			subpageAlert: @observable no

		computedProperties: () ->
			shortName: @computed () -> @name().length < 20

		subscriptions: () ->
			return [
				@url.subscribe (newValue) ->
					alert "Subpage has been triggered, by url subscription" if newValue is "/home/subpage"
			] 

		addHandler: () ->
			@names.push name: @name()
			@name ""

		removeHandler: () -> self.names.remove @

		initialize: (options) -> self = @
		removeAlert: () -> @subpageAlert no
		subpage: () -> @subpageAlert yes